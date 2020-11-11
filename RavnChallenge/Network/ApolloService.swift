//
//  NetworkService.swift
//  RavnChallenge
//
//  Created by Samuel Cornejo on 11/10/20.
//

import Apollo
import Combine
import Foundation

protocol ApolloServiceType: class {
    /// The URL to connect ApolloClient to.
    var url: URL { get }

    /// Fetches a query from the server using ApolloClient.
    /// - Parameter query: The query to fetch
    func fetch<Q: GraphQLQuery>(query: Q) -> AnyPublisher<Q.Data, Error>
}

struct ApolloServiceError: Error {
    let message: String
}

final class ApolloService: ApolloServiceType {
    // MARK: Singleton
    static let shared = ApolloService()

    // MARK: Variables Declaration
    var url: URL {
        URL(string: "https://swapi-graphql.netlify.app/.netlify/functions/index")!
    }

    private lazy var apollo = ApolloClient(url: url)

    // MARK: Initializer
    private init() { }

    // MARK: Public Methods
    func fetch<Query: GraphQLQuery>(query: Query) -> AnyPublisher<Query.Data, Error> {
        Future { [apollo] promise in
            apollo.fetch(query: query) { result in
                switch result {
                case .success(let graphQLResult):
                    if let data = graphQLResult.data {
                        promise(.success(data))
                    } else if let errors = graphQLResult.errors {
                        let message = errors.map(\.localizedDescription).joined(separator: "\n")
                        promise(.failure(ApolloServiceError(message: message)))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
