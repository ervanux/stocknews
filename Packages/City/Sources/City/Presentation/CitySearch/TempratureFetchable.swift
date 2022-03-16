//
//  TempratureFetchable.swift
//  BaseApp
//
//  Created by Erkan Ugurlu on 16.03.2022.
//

import Foundation

protocol TempratureFetchable {

    func loadTemp(with cityName: String) async throws -> CityTemp
}
