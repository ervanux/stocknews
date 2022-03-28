//
//  Article.swift
//  
//
//  Created by Erkan Ugurlu on 27.03.2022.
//

import Foundation

struct Article: Codable {
    let title: String?
    let publishedAt: String
    let urlToImage: String
    let description: String
}
