//
//  V.swift
//  LightweightValidation
//
//  Created by user on 11.04.20.
//  Copyright © 2020 yes. All rights reserved.
//

import Foundation

/// Simple validation result.
public enum V <T, E> {
    /// A valid value.
    case value(T)
    /// One or more errors.
    case error([E])
}

extension V {
    public var isValue: Bool {
        switch self {
        case .value: return true
        case .error: return false
        }
    }

    public var error: [E]? {
        switch self {
        case .error(let e): return e
        default: return nil
        }
    }
}

public func && <E> (lhs: V<(), E>, rhs: V<(), E>) -> V<(), E> {
    switch (lhs, rhs) {
    case (_, .value): return lhs
    case (.value, .error): return rhs
    case let (.error(e1), .error(e2)): return .error(e1 + e2)
    }
}

precedencegroup VGroup {
    associativity: left
    lowerThan: ComparisonPrecedence
    higherThan: LogicalConjunctionPrecedence
}

infix operator <?>: VGroup

/// Converts the `condition` to a `V` value. `true` means a valid value and `false`
/// is replaced with the `rhs` error.
public func <?> <E> (condition: Bool, rhs: @autoclosure () -> E) -> V<(), E> {
    condition
        ? .value(())
        : .error([rhs()])
}
