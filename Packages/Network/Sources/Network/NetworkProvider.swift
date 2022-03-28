//
//  NetworkProvider.swift
//
//
//  Created by Erkan Ugurlu on 16.03.2022.
//

import Foundation
import Combine
import CodableCSV

public struct NetworkProvider: NetworkProvidable {
    var session: URLSession
    var decoder: JSONDecoder

    public init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
}

///  Async/Await way
public extension NetworkProvider {
    
    func fetch<Model: Codable>(request: URLRequest) async throws -> Model {
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

///  Combine way
public extension NetworkProvider {

    func fetch(url: URL) -> AnyPublisher<Data, NetworkError> {
        let request = URLRequest(url: url)

        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.invalidResponse
                }
                return data
            }
            .mapError { error in
                if let error = error as? NetworkError {
                    return error
                } else {
                    return NetworkError.invalidData(error)
                }
            }
            .eraseToAnyPublisher()
    }

    func fetch<Model: Decodable>(url: URL) -> AnyPublisher<Model, NetworkError> {
        fetch(url: url)
            .decode(type: Model.self, decoder: decoder)
            .mapError { error in
                if let error = error as? DecodingError {
                    var errorToReport = error.localizedDescription
                    switch error {
                    case .dataCorrupted(let context):
                        let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                        errorToReport = "\(context.debugDescription) - (\(details))"
                    case .keyNotFound(let key, let context):
                        let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                        errorToReport = "\(context.debugDescription) (key: \(key), \(details))"
                    case .typeMismatch(let type, let context), .valueNotFound(let type, let context):
                        let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                        errorToReport = "\(context.debugDescription) (type: \(type), \(details))"
                    @unknown default:
                        break
                    }
                    return NetworkError.parserError(reason: errorToReport)
                }  else {
                    return NetworkError.invalidData(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
