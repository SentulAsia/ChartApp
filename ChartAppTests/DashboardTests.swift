//
//  DashboardTests.swift
//  ChartAppTests
//
//  Created by Zaid Said on 09/05/2020.
//  Copyright © 2020 Zaid Said. All rights reserved.
//

import XCTest
@testable import ChartApp

class DashboardTests: XCTestCase {

    typealias Models = DashboardModels
    typealias FetchDataStoreModels = Models.FetchFromRemoteDataStore
    var sut: DashboardWorker!

    override func setUpWithError() throws {
        sut = DashboardWorker()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testFetchFromRemoteDataStoreSuccess() throws {
        // given
        let apiManagerStub = APIManagerStub(response: [:], status: 201)
        sut.apiManager = apiManagerStub
        let request = FetchDataStoreModels.Request(scope: .all)
        let expect = expectation(description: "Wait for fetchFromRemoteDataStore(with:) to return")

        // when
        var isSuccessful: Bool!

        sut.fetchFromRemoteDataStore(with: request) { (viewModel) in
            isSuccessful = viewModel.isSuccessful
            expect.fulfill()
        }
        waitForExpectations(timeout: 1)

        // then
        XCTAssertTrue(isSuccessful, "request should be successful")
    }

    func testFetchFromRemoteDataStoreFailed() throws {
        // given
        let apiManagerStub = APIManagerStub(response: [:], status: 404)
        sut.apiManager = apiManagerStub
        let request = FetchDataStoreModels.Request(scope: .all)
        let expect = expectation(description: "Wait for fetchFromRemoteDataStore(with:) to return")

        // when
        var isSuccessful: Bool!

        sut.fetchFromRemoteDataStore(with: request) { (viewModel) in
            isSuccessful = viewModel.isSuccessful
            expect.fulfill()
        }
        waitForExpectations(timeout: 1)

        // then
        XCTAssertFalse(isSuccessful, "request should be not successful")
    }
}
