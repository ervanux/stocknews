//
//  NetworkProvidable.swift
//  
//
//  Created by Erkan Ugurlu on 16.03.2022.
//

import Foundation
import Combine

public protocol NetworkProvidable {
    func fetch<Model: Codable>(request: URLRequest) async throws -> Model
    func fetch<Model: Decodable>(url: URL) -> AnyPublisher<Model, NetworkError>
    func fetch(url: URL) -> AnyPublisher<Data, NetworkError> 
}
