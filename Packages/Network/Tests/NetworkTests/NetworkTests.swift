import XCTest
@testable import Network

final class NetworkTests: XCTestCase {
    var network: NetworkProvidable!
    let request = URLRequest(url: URL(string: "https://google.com")!)

    struct TestObject: Codable {
        let name: String
    }

    struct TestNetwork: NetworkProvidable {
        func fetch<Model: Codable>(request: URLRequest) async throws -> Model {
            return [TestObject(name: "test")] as! Model
        }
    }

    func testFetch() async throws {
        network = TestNetwork()

        do {
            let testObject: [TestObject] = try await network.fetch(request: request)
            XCTAssertEqual(1, testObject.count)
            XCTAssertEqual(testObject.first!.name, "test")
        } catch  {
            XCTAssertThrowsError(error)
        }
    }

    struct DummyNetworkWithError: NetworkProvidable {
        func fetch<Model: Codable>(request: URLRequest) async throws -> Model {
            throw NetworkError.invalidResponse
        }
    }

    func testFetchThrowsInvalidResponse() async throws {
        network = DummyNetworkWithError()
        do {
            let _: [TestObject] = try await network.fetch(request: request)
        } catch  {
            XCTAssertNoThrow(error)
        }
    }

    override func tearDownWithError() throws {
        network = nil
    }
}
