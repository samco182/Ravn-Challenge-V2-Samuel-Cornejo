//
//  StarWarsServiceTests.swift
//  RavnChallengeTests
//
//  Created by Samuel Cornejo on 11/11/20.
//

import Combine
import XCTest
@testable import RavnChallenge

class StarWarsServiceTests: XCTestCase {
    // MARK: Public Methods
    func testWhenQueryFetchingIsSuccess() {
        // Given
        let service = ApolloServiceMock()
        let starWarsService = StarWarsService(service: service)
        let expectation = XCTestExpectation(description: "Async Sink Test")

        // When
        let result = starWarsService.fetchPeople(resultsPerPage: 1, endCursor: nil)

        // Then
        let cancellable = result
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { response in
                XCTAssertTrue(response.page.hasNextPage)
                XCTAssertEqual(1, response.people.count)
                XCTAssertEqual("Person #1", response.people.first?.name)
            }

        wait(for: [expectation], timeout: 2.0)

        XCTAssertNotNil(cancellable)
    }

    func testWhenQueryFetchingIsFailure() {
        // Given
        let service = ApolloServiceMock(shouldFail: true)
        let starWarsService = StarWarsService(service: service)
        let expectation = XCTestExpectation(description: "Async Sink Test")

        // When
        let result = starWarsService.fetchPeople(resultsPerPage: 1, endCursor: nil)

        // Then
        let cancellable = result
            .sink { result in
                expectation.fulfill()

                if case Subscribers.Completion.failure(let error) = result {
                    XCTAssert(error is ApolloServiceError)
                    XCTAssertEqual((error as? ApolloServiceError)?.message, "This failed!")
                }
            } receiveValue: { _ in }

        wait(for: [expectation], timeout: 2.0)

        XCTAssertNotNil(cancellable)
    }
}
