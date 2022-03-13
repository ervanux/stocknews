//
//  Todo.swift
//  BaseApp
//
//  Created by Erkan Ugurlu on 16.03.2022.
//

import Foundation

struct Todo: Codable {
    let userId: Int
    let title: String
    let completed: Bool
}
