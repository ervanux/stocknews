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
import CodableCSV

class StockNewsViewModel {
    var articles = Observable<[Article]>(nil)
    var prices = Observable<[StockPrice]>(nil)

    var stockSubscriber: AnyCancellable?
    var newsSubscriber: AnyCancellable?

    init() {
        if let url = URL(string: Endpoints.news.constructUrl()) {
            loadNews(with: url)
        }

        if let url = URL(string: Endpoints.stocks.constructUrl()) {
            loadStocks(with: url)
        }
    }
}

extension StockNewsViewModel {

    func itemCount(of section: Section) -> Int {
        switch section {
        case .stock:
            return prices.value?.count ?? 0
        case .photoNews:
            return Swift.min(articles.value?.count ?? 0, 6)
        case .textNews:
            return articles.value?[5...].count ?? 0
        }
    }

    func sectionTitle(section: Section) -> String {
        switch section {
        case .stock:
            return "Stock Prices"
        case .photoNews:
            return "Highlited News"
        case .textNews:
            return "Whole News"
        }
    }
}

extension StockNewsViewModel {
    fileprivate func loadStocks(with url: URL) {
        var config = CSVDecoder.Configuration()
        config.headerStrategy = .firstLine
        config.trimStrategy = .whitespaces
        let decoder = CSVDecoder(configuration: config)

        stockSubscriber = Coordinator.shared.network
            .fetch(url: url)
            .decode(type: [StockPrice].self, decoder: decoder)
            .sink(receiveCompletion: { completion in
//                print(completion)
            }, receiveValue: {[weak self] price in
                self?.prices.value = Dictionary(grouping: price, by: { $0.title }).values
                    .compactMap { $0.randomElement() }
                    .sorted(by: { $0.title < $1.title })

                DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + 1) {
                    self?.loadStocks(with: url)
                }
            })
    }

    func loadNews(with url: URL) {
        newsSubscriber = Coordinator.shared.network
            .fetch(url: url)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: {[weak self] (model: News) in
                self?.articles.value =  model.articles
            })
    }
}
