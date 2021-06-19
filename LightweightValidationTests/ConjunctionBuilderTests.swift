//
//  ConjunctionBuilderTests.swift
//  LightweightValidationTests
//
//  Created by user on 19.06.2021.
//  Copyright © 2021 yes. All rights reserved.
//

#if swift(>=5.4)
import LightweightValidation
import XCTest

class ConjunctionBuilderTests: XCTestCase {
    func testValidStepShouldReturnItself() {
        let sut = Response.SimpleValidationResult.all {
            true <?> StringError("never happens")
        }
        XCTAssertTrue(sut.isValue)
    }

    func testInvalidStepShouldReturnItself() {
        let sut = Response.SimpleValidationResult.all {
            false <?> StringError("always fails")
        }
        XCTAssertEqual(sut.error, ["always fails"])
    }

    func testTwoStepsShouldBeCombined() {
        let sut = Response.SimpleValidationResult.all {
            true <?> StringError("never happens")
            false <?> StringError("always fails")
        }
        XCTAssertEqual(sut.error, ["always fails"])
    }
}
#endif