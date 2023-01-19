//
//  PasswordCriteriaTests.swift
//  PasswordTests
//
//  Created by Natália Sapucaia on 19/01/23.
//

import XCTest

@testable import Password

class PasswordLengthCriteriaTests: XCTestCase {
    func testShort() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("1234567"))
    }

    func testLong() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("012345678901234567890123456789123"))

    }

    func testValidShort() throws {
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678"))
    }

    func testValidLong() throws {
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("01234567890123456789012345678912"))
    }
}

class PasswordOtherCriteriaTests: XCTestCase {
    func testSpaceMet() throws {
        XCTAssertTrue(PasswordCriteria.noSpaceCriteriaMet("abc"))
    }

    func testSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.noSpaceCriteriaMet("a bc"))
    }

    func testLengthAndNoSpaceMet() throws {
        XCTAssertTrue(PasswordCriteria.lengthAndNoSpaceMet("12345678"))
    }

    func testLengthAndNoSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.lengthAndNoSpaceMet("1234567 8"))
    }

    func testLengthNotAndNoSpaceMet() throws {
        XCTAssertFalse(PasswordCriteria.lengthAndNoSpaceMet("1234567"))
    }

    func testUppercaseMet() throws {
        XCTAssertTrue(PasswordCriteria.uppercaseMet("C"))
    }

    func testUppercaseNotMet() throws {
        XCTAssertFalse(PasswordCriteria.uppercaseMet("a"))
    }

    func testLowercaseMet() throws {
        XCTAssertTrue(PasswordCriteria.lowercaseMet("a"))
    }

    func testLowercaseNotMet() throws {
        XCTAssertFalse(PasswordCriteria.lowercaseMet("B"))
    }

    func testDigitMet() throws {
        XCTAssertTrue(PasswordCriteria.digitMet("3"))
    }

    func testDigitNotMet() throws {
        XCTAssertFalse(PasswordCriteria.digitMet("a"))
    }

    func testSpecialCharacterMet() throws {
        XCTAssertTrue(PasswordCriteria.specialCharacterMet("$"))
    }

    func testSpecialCharacterNotMet() throws {
        XCTAssertFalse(PasswordCriteria.specialCharacterMet("1"))
    }
}
