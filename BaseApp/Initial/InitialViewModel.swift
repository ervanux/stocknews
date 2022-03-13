//
//  InitialViewModel.swift
//  BaseApp
//
//  Created by Erkan Ugurlu on 13.03.2022.
//

import Foundation
import Network
import Core

protocol InitialFetchable {
    func loadTodos() async throws -> [Todo]
}

class InitialViewModel {
    private let repository: InitialFetchable
    var todos: Observable<[Todo]> = Observable(nil)

    init(repository: InitialFetchable) {
        self.repository = repository
    }

    func loadTodos() {
        Task {
            do {
                todos.value = try await repository.loadTodos()
            } catch {
                print(error)
            }
        }
    }
}
