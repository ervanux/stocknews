//
//  TestCitySearchViewModel.swift
//  BaseAppTests
//
//  Created by Erkan Ugurlu on 16.03.2022.
//

import XCTest
@testable import BaseApp

class TestCitySearchViewModel: XCTestCase {

    var viewModel: CitySearchViewModel!

    struct TestRepo: TempratureFetchable {
        func loadTemp(with cityName: String) async throws -> CityTemp {
            return CityTemp(main: Temprature(temp: 123))
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = CitySearchViewModel(repository: TestRepo())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func testLoadTempInvalidCityName() {
        XCTAssertThrowsError(try viewModel.loadTemp(with: ""))
    }
}
