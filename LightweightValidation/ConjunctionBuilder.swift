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
    public static func buildBlock <T, E> (_ validations: V<T, E>...) -> V<T, E> {
        validations[0]
    }
}

public extension V {
    static func all(@ConjunctionBuilder _ validations: () -> V<T, E>) -> V<T, E> {
        validations()
    }
}
#endif
