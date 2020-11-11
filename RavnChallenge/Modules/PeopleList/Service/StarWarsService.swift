//
//  StarWarsService.swift
//  RavnChallenge
//
//  Created by Samuel Cornejo on 11/10/20.
//

import Apollo
import Combine
import Foundation

protocol StarWarsServiceType {
    /// Fetches people available on StarWars API.
    /// - Parameters:
    ///   - resultsPerPage: The number of results per page
    ///   - endCursor: A reference to the last item of the page
    func fetchPeople(resultsPerPage: Int, endCursor: String?) -> AnyPublisher<StarWarsPeopleResponse, Error>
}

struct StarWarsService: StarWarsServiceType {
    // MARK: Variables Declaration
    private let service: ApolloServiceType

    // MARK: Initializer
    init(service: ApolloServiceType = ApolloService.shared) {
        self.service = service
    }

    // MARK: Public Methods
    func fetchPeople(resultsPerPage: Int, endCursor: String?) -> AnyPublisher<StarWarsPeopleResponse, Error> {
        service.fetch(query: StarWarsPeopleQuery(first: resultsPerPage, after: endCursor))
            .map { StarWarsPeopleResponse(data: $0) }
            .eraseToAnyPublisher()
    }
}
