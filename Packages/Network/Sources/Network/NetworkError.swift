//
//  NetworkError.swift
//  
//
//  Created by Erkan Ugurlu on 16.03.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case invalidData(Error)
}
