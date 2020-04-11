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

    public var isError: Bool {
        !self.isValue
    }
}

public func && <E> (lhs: V<(), E>, rhs: V<(), E>) -> V<(), E> {
    switch (lhs, rhs) {
    case (_, .value): return lhs
    case (.value, .error): return rhs
    case let (.error(e1), .error(e2)): return .error(e1 + e2)
    }
}

extension Bool {
    var V: V<(), StringError> {
        self ? .value(()) : .error([StringError("Failed validation")])
    }
}
