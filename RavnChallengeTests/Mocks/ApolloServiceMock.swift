//
//  ApolloServiceMock.swift
//  RavnChallengeTests
//
//  Created by Samuel Cornejo on 11/11/20.
//

import Apollo
import Combine
import Foundation
@testable import RavnChallenge

class ApolloServiceMock: ApolloServiceType {
    // MARK: Variables Declaration
    let shouldFail: Bool

    var url: URL {
        URL(string: "https://www.google.com")!
    }

    // MARK: Initializer
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
    }

    // MARK: Public Methods
    func fetch<Query: GraphQLQuery>(query: Query) -> AnyPublisher<Query.Data, Error> {
        if shouldFail {
            return Fail(error: ApolloServiceError(message: "This failed!"))
                .eraseToAnyPublisher()
        } else {
            // swiftlint:disable:next force_cast
            let starWarsQuery = query as! StarWarsPeopleQuery
            let pageInfo = PageInformation(hasNextPage: true)
            let people = (0..<starWarsQuery.first!).map { Person(id: "\($0+1)", name: "Person #\($0+1)") }
            let data = StarWarsPeopleQuery.Data.AllPerson(pageInfo: pageInfo, people: people)
            // swiftlint:disable:next force_cast
            return Just(StarWarsPeopleQuery.Data(allPeople: data) as! Query.Data)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
