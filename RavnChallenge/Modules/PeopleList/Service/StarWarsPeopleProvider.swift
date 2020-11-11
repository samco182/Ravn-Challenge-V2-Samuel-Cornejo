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
    var cancellable: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()

    // Input
    private let fetchPeopleRequest = PassthroughRelay<Void>()
    private let fetchMorePeopleRequest = PassthroughRelay<Void>()

    // Output
    private var currentPage: PageInformation = .init(hasNextPage: true)

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
        fetchPeopleRequest.accept(())
    }

    func fetchMorePeople(after person: Person) {
        guard person == people.last, currentPage.hasNextPage, !isLoading else { return }
        fetchMorePeopleRequest.accept(())
    }

    // MARK: Private Methods
    private func setupBindings() {
        // Input
        let fetchRequest = Publishers.Merge(fetchPeopleRequest, fetchMorePeopleRequest)
            .compactMap { [weak self] _ in self?.currentPage }

        // Output
        let peopleResult = fetchRequest
            .flatMapLatest(on: self) { weakSelf, currentPage in
                weakSelf.service.fetchAllPeople(resultsPerPage: 5, endCursor: currentPage.endCursor).materialize()
            }
            .share()

        peopleResult
            .values()
            .map(\.page)
            .assign(to: \.currentPage, on: self, ownership: .weak)
            .store(in: &cancellables)

        peopleResult
            .values()
            .map(\.people)
            .sink(receiveValue: { [weak self] people in
                self?.people.append(contentsOf: people)
            })
            .store(in: &cancellables)

        peopleResult
            .failures()
            .map { _ in true }
            .assign(to: \.requestDidFail, on: self, ownership: .weak)
            .store(in: &cancellables)

        Publishers.Merge(fetchRequest.map { _ in true }, peopleResult.map { _ in false })
            .assign(to: \.isLoading, on: self, ownership: .weak)
            .store(in: &cancellables)
    }
}
