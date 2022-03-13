//
//  NetworkProvidable.swift
//  
//
//  Created by Erkan Ugurlu on 16.03.2022.
//

import Foundation

public protocol NetworkProvidable {
    func fetch<Model: Codable>(request: URLRequest) async throws -> Model
}
