//
//  ConjunctionBuilder.swift
//  LightweightValidation
//
//  Created by user on 19.06.2021.
//  Copyright © 2021 yes. All rights reserved.
//

#if swift(>=5.4)
import Foundation

@resultBuilder
public struct ConjunctionBuilder {
    public static func buildBlock <E> (_ validations: V<(), E>...) -> V<(), E> {
        // as I understand, `validations` cannot be empty here because if the user supplied no validations,
        // `buildBlock()` would be called if it were implemented
        validations.dropFirst().reduce(validations[0]) { result, validation in
            result && validation
        }
    }
}

public extension V {
    static func all(@ConjunctionBuilder _ validations: () -> V<T, E>) -> V<T, E> {
        validations()
    }
}
#endif
