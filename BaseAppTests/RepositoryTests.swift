//
//  RepositoryTests.swift
//  BaseAppTests
//
//  Created by Erkan Ugurlu on 16.03.2022.
//

import XCTest
@testable import BaseApp
@testable import Network

class RepositoryTests: XCTestCase {
    var repo: Repository!
    var network: NetworkProvidable!

    override func setUpWithError() throws {
    }

    struct DummyNetwork: NetworkProvidable {
        func fetch<Model: Codable>(request: URLRequest) async throws -> Model {
            return [Todo(userId: 1, title: "title", completed: false)] as! Model
        }
    }

    func testLoadTodo() async throws {
        network = DummyNetwork()
        repo = Repository(network: network)

        do {
            let todos: [Todo] = try await repo.loadTodos()
            XCTAssertEqual(1, todos.count)
            XCTAssertEqual(todos.first!.title, "title")
            XCTAssertEqual(todos.first!.userId, 1)
            XCTAssertEqual(todos.first!.completed, false)
        } catch  {
            XCTAssertThrowsError(error)
        }
    }

    struct DummyNetworkWithError: NetworkProvidable {
        func fetch<Model: Codable>(request: URLRequest) async throws -> Model {
            throw RepositoryError.fetchProblem
        }
    }

    func testLoadTodoThrowsFetchError() async throws {
        network = DummyNetworkWithError()
        repo = Repository(network: network)
        do {
            let _: [Todo] = try await repo.loadTodos()
        } catch  {
            XCTAssertNoThrow(error)
        }
    }

    override func tearDownWithError() throws {
        network = nil
        repo = nil
    }
}
