//
//  ResponseValidator.swift
//  LightweightValidation
//
//  Created by user on 11.04.20.
//  Copyright © 2020 yes. All rights reserved.
//

import Foundation

/// A sample response from a service.
public struct Response {
    /// An identifier to correlate the response with its request.
    let correlationId: Int
    /// User who created the data provided in this response.
    let userName: String
    /// Some extra data.
    let extraData: Data

    public init(correlationId: Int, userName: String, extraData: Data) {
        self.correlationId = correlationId
        self.userName = userName
        self.extraData = extraData
    }
}

extension Response {
    public typealias SimpleValidationResult = V<(), StringError>

    public func validate(sentIds: Set<Int>) -> SimpleValidationResult {
        validateCorrelationId(sentIds)
            && validateUserName()
    }

    /// The correlation id must be in the list of correlation ids of sent requests.
    private func validateCorrelationId(_ sentIds: Set<Int>) -> SimpleValidationResult {
        sentIds.contains(correlationId) <?> StringError("Correlation id \(correlationId) is not in the sent ids set \(sentIds)")
    }

    /// Usernames are minimum 3 chars long and cannot include `@`.
    private func validateUserName() -> SimpleValidationResult {
        userName.count >= 3 <?> StringError("Username \(userName) must be 3+ chars")
            && !userName.contains("@") <?> StringError("Username \(userName) must not contain '@'")
    }
}
