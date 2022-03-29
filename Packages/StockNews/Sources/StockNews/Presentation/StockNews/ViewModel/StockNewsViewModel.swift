//
//  File.swift
//  
//
//  Created by Erkan Ugurlu on 27.03.2022.
//

import Foundation
import Network
import Combine
import Core

class StockNewsViewModel {
    let prices = CurrentValueSubject<[StockPrice], Never>([])
    let articles = CurrentValueSubject<[Article], Never>([])

    var stockSubscriber: AnyCancellable?
    var newsSubscriber: AnyCancellable?

    let repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }

    var errorOccured: ((String?) -> Void)?
    func fetchContent(errorOccured: @escaping (String?) -> Void) {
        self.errorOccured = errorOccured
        fetchNews()
        fetchStocks()
    }
}

extension StockNewsViewModel {

    func itemCount(of section: Section) -> Int {
        switch section {
        case .stock:
            return prices.value.count
        case .photoNews:
            return Swift.min(articles.value.count, 6)
        case .textNews:
            return Swift.max(articles.value.count - 6, 0)
        }
    }

    func sectionTitle(section: Section) -> String {
        switch section {
        case .stock:
            return "Stock Prices"
        case .photoNews:
            return "Highlighted News"
        case .textNews:
            return "Whole News"
        }
    }
}

private extension StockNewsViewModel {

    func fetchStocks() {
        stockSubscriber = repository.loadStocks()
            .sink(receiveCompletion: {[weak self] completion in
                switch completion {
                case .finished:
                    // TODO: there might be a Combine way?
                    DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + 1) {
                        self?.fetchStocks()
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    self?.errorOccured?(error.localizedDescription)
                }
            }, receiveValue: {[weak self] prices in
                self?.prices.value = prices
            })
    }

    func fetchNews() {
        newsSubscriber = repository.loadNews()
            .sink(receiveCompletion: {[weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    self?.errorOccured?(error.localizedDescription)
                }
            }, receiveValue: {[weak self] (model: News) in
                self?.articles.value =  model.articles
            })
    }
}
