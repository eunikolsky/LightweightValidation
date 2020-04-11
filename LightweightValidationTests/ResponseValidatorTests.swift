//
//  ResponseValidatorTests.swift
//  LightweightValidationTests
//
//  Created by user on 11.04.20.
//  Copyright © 2020 yes. All rights reserved.
//

import LightweightValidation
import XCTest

class ResponseValidatorTests: XCTestCase {
    private typealias T = ResponseValidatorTests

    static let anonymousCorrelationId = 200

    func testCorrelationIdInSentIdsShouldBeValid() {
        let sut = response(withCorrelationId: 100)
        XCTAssertTrue(sut.validate(sentIds: [1, 100, 9000]).isValue)
    }

    func testCorrelationIdNotInSentIdsShouldBeInvalid() {
        let sut = response(withCorrelationId: 99)
        XCTAssertEqual(sut.validate(sentIds: [1, 10]).error, ["Correlation id 99 is not in the sent ids set [1, 10]"])
    }

    func testLongUserNameShouldBeValid() {
        let sut = response(withUserName: "123")
        XCTAssertTrue(sut.validate(sentIds: [T.anonymousCorrelationId]).isValue)
    }

    func testShortUserNameShouldBeInvalid() {
        let sut = response(withUserName: "ab")
        XCTAssertEqual(sut.validate(sentIds: [T.anonymousCorrelationId]).error, ["Username ab must be 3+ chars"])
    }

    func testUserNameWithAtSymbolShouldBeInvalid() {
        let sut = response(withUserName: "ab@foo")
        XCTAssertEqual(sut.validate(sentIds: [T.anonymousCorrelationId]).error, ["Username ab@foo must not contain '@'"])
    }

    func testValidationErrorsShouldAccumulate() {
        let sut = response(withCorrelationId: 99, withUserName: "a@")
        XCTAssertEqual(sut.validate(sentIds: [T.anonymousCorrelationId]).error.map(Set.init),
                       Set(["Correlation id 99 is not in the sent ids set [200]",
                            "Username a@ must not contain '@'",
                            "Username a@ must be 3+ chars"]))
    }

    // MARK: - Helpers

    func response(withCorrelationId: Int = T.anonymousCorrelationId,
                  withUserName: String = "foo") -> Response {
        Response(correlationId: withCorrelationId, userName: withUserName, extraData: Data())
    }
}
