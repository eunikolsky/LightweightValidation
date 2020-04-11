//
//  ResponseValidator.swift
//  LightweightValidation
//
//  Created by user on 11.04.20.
//  Copyright © 2020 yes. All rights reserved.
//

import Foundation

/// A sample response from a service.
struct Response {
    /// An identifier to correlate the response with its request.
    let correlationId: Int
    /// User who created the data provided in this response.
    let userName: String
    /// Some extra data.
    let extraData: Data
}
