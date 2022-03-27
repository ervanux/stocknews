//
//  NetworkError.swift
//  
//
//  Created by Erkan Ugurlu on 16.03.2022.
//

import Foundation

public enum NetworkError: Error {
    case invalidResponse
    case invalidData(Error)
    case parserError(reason: String)
}
