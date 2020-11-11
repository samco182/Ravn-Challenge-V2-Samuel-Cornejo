//
//  StarWarsPeopleProvider.swift
//  RavnChallenge
//
//  Created by Samuel Cornejo on 11/10/20.
//

import Combine
import CombineExt
import Foundation

final class StarWarsPeopleProvider: ObservableObject {
    // MARK: Variables Declaration
    private let service: StarWarsServiceType
    private let peopleRequest = PassthroughRelay<Void>()
    private var cancellables = Set<AnyCancellable>()

    // Output
    @Published var people: [Person] = []
    @Published var requestDidFail: Bool = false
    @Published var isLoading: Bool = false

    // MARK: Initializer
    init(service: StarWarsServiceType = StarWarsService()) {
        self.service = service

        setupBindings()
    }

    // MARK: Public Methods
    func fetchPeople() {
        peopleRequest.accept(())
    }

    // MARK: Private Methods
    private func setupBindings() {
        // Output
        let peopleResult = peopleRequest
            .flatMapLatest(on: self) { weakSelf, _ in
                weakSelf.service.fetchAllPeople(resultsPerPage: 5, endCursor: "").materialize()
            }
            .share()

        peopleResult
            .values()
            .map(\.people)
            .assign(to: \.people, on: self, ownership: .weak)
            .store(in: &cancellables)

        peopleResult
            .failures()
            .map { _ in true }
            .assign(to: \.requestDidFail, on: self, ownership: .weak)
            .store(in: &cancellables)

        Publishers.Merge(peopleRequest.map { true }, peopleResult.map { _ in false })
            .assign(to: \.isLoading, on: self, ownership: .weak)
            .store(in: &cancellables)
    }
}
