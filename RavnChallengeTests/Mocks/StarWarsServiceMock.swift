//
//  StarWarsServiceMock.swift
//  RavnChallengeTests
//
//  Created by Samuel Cornejo on 11/11/20.
//

import Apollo
import Combine
import Foundation
@testable import RavnChallenge

struct StarWarsServiceMock: StarWarsServiceType {
    // MARK: Variables Declaration
    let shouldFail: Bool

    // MARK: Initializer
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
    }

    // MARK: Public Methods
    func fetchPeople(resultsPerPage: Int, endCursor: String?) -> AnyPublisher<StarWarsPeopleResponse, Error> {
        if shouldFail {
            return Fail(error: ApolloServiceError(message: "This failed!"))
                .eraseToAnyPublisher()
        } else if endCursor == "qwerty" {
            let pageInfo = PageInformation(hasNextPage: true, endCursor: "uiop")
            let people = (0..<resultsPerPage).map { Person(id: "\($0+5)", name: "Person #\($0+5)") }
            let allPeople = StarWarsPeopleQuery.Data.AllPerson(pageInfo: pageInfo, people: people)
            let data = StarWarsPeopleQuery.Data(allPeople: allPeople)
            return Just(StarWarsPeopleResponse(data: data))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            let pageInfo = PageInformation(hasNextPage: true, endCursor: "qwerty")
            let people = (0..<resultsPerPage).map { Person(id: "\($0+1)", name: "Person #\($0+1)") }
            let allPeople = StarWarsPeopleQuery.Data.AllPerson(pageInfo: pageInfo, people: people)
            let data = StarWarsPeopleQuery.Data(allPeople: allPeople)
            return Just(StarWarsPeopleResponse(data: data))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
