//
//  RepositoryError.swift
//  BaseApp
//
//  Created by Erkan Ugurlu on 16.03.2022.
//

import Foundation

enum RepositoryError: Error {
    case invalidEndpointUrl
    case fetchProblem
}
