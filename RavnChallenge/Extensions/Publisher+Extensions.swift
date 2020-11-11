//
//  Publisher+Extensions.swift
//  RavnChallenge
//
//  Created by Samuel Cornejo on 11/11/20.
//

import Combine
import Foundation

extension Publisher {
    // swiftlint:disable:next line_length
    func flatMapLatest<O: AnyObject, P: Publisher>(on owner: O, _ transform: @escaping (O, Output) -> P) -> Publishers.SwitchToLatest<P, Publishers.CompactMap<Self, P>> {
        compactMap { [weak owner] output -> P? in
            guard let weakSelf = owner else { return nil }
            return transform(weakSelf, output)
        }
        .switchToLatest()
    }
}
