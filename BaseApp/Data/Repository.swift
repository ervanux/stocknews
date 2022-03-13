//
//  Repository.swift
//  BaseApp
//
//  Created by Erkan Ugurlu on 13.03.2022.
//

import Foundation
import Network

class Repository {
    private let network: NetworkProvidable

    init(network: NetworkProvidable) {
        self.network = network
    }
}

extension Repository: InitialFetchable {
    func loadTodos() async throws -> [Todo] {
        guard let url = URL(string: Endpoints.todos.rawValue) else {
            throw RepositoryError.invalidEndpointUrl
        }

        do {
            let request = URLRequest(url: url)
            return try await network.fetch(request: request)
        } catch {
            throw RepositoryError.fetchProblem
        }
    }
}
