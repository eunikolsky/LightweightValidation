//
//  V.swift
//  LightweightValidation
//
//  Created by user on 11.04.20.
//  Copyright © 2020 yes. All rights reserved.
//

import Foundation

/// Simple validation result.
public enum V <T> {
    /// A valid value.
    case value(T)
    /// An error.
    case error
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

public func && (lhs: V<()>, rhs: V<()>) -> V<()> {
    switch (lhs, rhs) {
    case (.value, .value): return lhs
    default: return .error
    }
}

extension Bool {
    var V: V<()> {
        self ? .value(()) : .error
    }
}
