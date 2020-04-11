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
        XCTAssertTrue(sut.validate(sentIds: [1, 100, 9000]))
    }

    func testCorrelationIdNotInSentIdsShouldBeInvalid() {
        let sut = response(withCorrelationId: 99)
        XCTAssertFalse(sut.validate(sentIds: [1, 10]))
    }

    func testLongUserNameShouldBeValid() {
        let sut = response(withUserName: "123")
        XCTAssertTrue(sut.validate(sentIds: [T.anonymousCorrelationId]))
    }

    func testShortUserNameShouldBeInvalid() {
        let sut = response(withUserName: "ab")
        XCTAssertFalse(sut.validate(sentIds: [T.anonymousCorrelationId]))
    }

    func testUserNameWithAtSymbolShouldBeInvalid() {
        let sut = response(withUserName: "ab@foo")
        XCTAssertFalse(sut.validate(sentIds: [T.anonymousCorrelationId]))
    }

    // MARK: - Helpers

    func response(withCorrelationId: Int = T.anonymousCorrelationId,
                  withUserName: String = "foo") -> Response {
        Response(correlationId: withCorrelationId, userName: withUserName, extraData: Data())
    }
}
