//
//  StockPrice.swift
//  
//
//  Created by Erkan Ugurlu on 28.03.2022.
//

import Foundation

struct StockPrice: Codable {
    let title: String
    let price: Double

    enum CodingKeys: Int, CodingKey {
        case title = 0
        case price = 1
    }
}
