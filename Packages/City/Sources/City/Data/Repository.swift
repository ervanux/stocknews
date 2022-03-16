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

extension Repository: TempratureFetchable {

    func loadTemp(with cityName: String) async throws -> CityTemp {
        guard let url = URL(string: Endpoints.weather(city: cityName).constructUrl()) else {
            throw RepositoryError.invalidEndpointUrl
        }

        do {
            let request = URLRequest(url: url)
            let cityTemp: CityTemp = try await network.fetch(request: request)
            return cityTemp
        } catch {
            throw RepositoryError.fetchProblem
        }
    }
}

struct CityTemp: Codable {
    let main: Temprature
}

struct Temprature: Codable {
    let temp: Double // TODO: can be decimal
}
