//
//  Endpoints.swift
//  BaseApp
//
//  Created by Erkan Ugurlu on 16.03.2022.
//

import Foundation

enum Endpoints {
    case todos
    case weather(city: String)
}

extension Endpoints {

    func constructUrl() -> String {

        switch self {
        case .weather(let city):
            return "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=3fc9cb54394cc7ad0010daa12eb9e286"
        case .todos:
            return "https://jsonplaceholder.typicode.com/todos"
        }
    }
}
