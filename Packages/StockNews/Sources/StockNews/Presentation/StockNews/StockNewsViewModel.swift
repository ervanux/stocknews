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
    var articles = Observable<[Article]>(nil)

    var subscribers: Set<AnyCancellable> = []

    init() {
        if let url = URL(string: Endpoints.news.constructUrl()) {
            load(url: url)
        }
    }

    func load(url: URL) {
        Coordinator.shared.network
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
            }).store(in: &subscribers)
    }
}
