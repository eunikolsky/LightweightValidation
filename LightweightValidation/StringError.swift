//
//  StringError.swift
//  LightweightValidation
//
//  Created by u on 11.04.20.
//  Copyright © 2020 yes. All rights reserved.
//

import Foundation

/// Primitive error type that contains only a message string.
public struct StringError {
    let message: String

    public init(_ message: String) {
        self.message = message
    }
}
