//
//  CitySearchViewModel.swift
//  BaseApp
//
//  Created by Erkan Ugurlu on 16.03.2022.
//

import Foundation
import Core

class CitySearchViewModel {
    private let repository: TempratureFetchable
    var model = Observable<CityTemp>(nil)

    init(repository: TempratureFetchable) {
        self.repository = repository
    }
}

extension CitySearchViewModel {

    func loadTemp(with cityName: String?) throws {
        // TODO: Validate city name

        guard let name = cityName, name.count > 2 else {
            throw BusinessError.invalidCityName
        }

        Task {
            do {
                model.value = try await repository.loadTemp(with: name)
            } catch {
                // TODO: handle error
                print("\(error)")
            }
        }
    }
}

enum BusinessError: Error {
    case invalidCityName

}
