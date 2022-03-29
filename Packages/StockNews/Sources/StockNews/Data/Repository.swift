//
//  Repository.swift
//  BaseApp
//
//  Created by Erkan Ugurlu on 13.03.2022.
//

import Foundation
import Network
import Combine
import CodableCSV

class Repository {
    private let network: NetworkProvidable

    init(network: NetworkProvidable) {
        self.network = network
    }

    lazy var csvDecoder: CSVDecoder = {
        var config = CSVDecoder.Configuration()
        config.headerStrategy = .firstLine
        config.trimStrategy = .whitespaces
        let decoder = CSVDecoder(configuration: config)
        return decoder
    }()
}

extension Repository {

    func loadStocks() -> AnyPublisher<[StockPrice], Error> {
        guard let url = URL(string: Endpoints.stocks.constructUrl()) else {
            fatalError("URL string is not valid!")
        }

        return network
            .fetch(url: url)
            .decode(type: [StockPrice].self, decoder: csvDecoder)
            .flatMap({ price in
                Just(Dictionary(grouping: price, by: { $0.title }).values
                        .compactMap { $0.randomElement() }
                        .sorted(by: { $0.title < $1.title }))
            }).eraseToAnyPublisher()
    }

    func loadNews() -> AnyPublisher<News, NetworkError> {
        guard let url = URL(string: Endpoints.news.constructUrl()) else {
            fatalError("URL is not valid!")
        }

        return network
            .fetch(url: url)
            .eraseToAnyPublisher()
    }
}
