//
//  NetworkProvider.swift
//
//
//  Created by Erkan Ugurlu on 16.03.2022.
//

import Foundation

public struct NetworkProvider: NetworkProvidable {
    var session: URLSession
    var decoder: JSONDecoder

    public init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }

    public func fetch<Model: Codable>(request: URLRequest) async throws -> Model {
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }

        do {
            let model = try decoder.decode(Model.self, from: data)
            return model
        } catch {
            throw NetworkError.invalidData(error)
        }
    }
}
