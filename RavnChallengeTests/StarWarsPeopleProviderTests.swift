//
//  StarWarsPeopleProviderTests.swift
//  RavnChallengeTests
//
//  Created by Samuel Cornejo on 11/11/20.
//

import Combine
import XCTest
@testable import RavnChallenge

class StarWarsPeopleProviderTests: XCTestCase {
    // MARK: Public Methods
    func testWhenFirstFetchIsSuccess() {
        // Given
        let service = StarWarsServiceMock()
        let provider = StarWarsPeopleProvider(service: service, resultsPerPage: 5)

        // When
        provider.fetchPeople()

        // Then
        XCTAssertEqual("qwerty", provider.currentPage.endCursor)
        XCTAssertEqual(5, provider.people.count)
        XCTAssertFalse(provider.requestDidFail)
    }

    func testWhenFirstFetchIsFailure() {
        // Given
        let service = StarWarsServiceMock(shouldFail: true)
        let provider = StarWarsPeopleProvider(service: service, resultsPerPage: 5)

        // When
        provider.fetchPeople()

        // Then
        XCTAssertTrue(provider.requestDidFail)
    }

    func testWhenFetchFiveMoreIsSuccess() {
        // Given
        let service = StarWarsServiceMock()
        let people = (0..<5).map { Person(id: "\($0+1)", name: "Person #\($0+1)") }
        let provider = StarWarsPeopleProvider(service: service,
                                              currentPage: .init(hasNextPage: true, endCursor: "qwerty"),
                                              resultsPerPage: 5,
                                              people: people)

        // When
        provider.fetchMorePeople(after: Person(id: "5"))

        // Then
        XCTAssertEqual("uiop", provider.currentPage.endCursor)
        XCTAssertEqual(10, provider.people.count)
        XCTAssertFalse(provider.requestDidFail)
    }

    func testWhenFetchFiveMoreIsFailure() {
        // Given
        let service = StarWarsServiceMock(shouldFail: true)
        let people = (0..<5).map { Person(id: "\($0+1)", name: "Person #\($0+1)") }
        let provider = StarWarsPeopleProvider(service: service,
                                              currentPage: .init(hasNextPage: true, endCursor: "qwerty"),
                                              resultsPerPage: 5,
                                              people: people)

        // When
        provider.fetchMorePeople(after: Person(id: "5"))

        // Then
        XCTAssertEqual("qwerty", provider.currentPage.endCursor)
        XCTAssertEqual(5, provider.people.count)
        XCTAssertTrue(provider.requestDidFail)
    }
}
