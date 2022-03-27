//
//  Endpoints.swift
//  BaseApp
//
//  Created by Erkan Ugurlu on 16.03.2022.
//

import Foundation

enum Endpoints {
    case stocks
    case news
}

extension Endpoints {

    func constructUrl() -> String {
        switch self {
        case .stocks:
            return "https://raw.githubusercontent.com/dsancov/TestData/main/stocks.csv"
        case .news:
            return "https://saurav.tech/NewsAPI/everything/cnn.json"
        }
    }
}
