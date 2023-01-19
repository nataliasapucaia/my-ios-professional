//
//  PassworsStatusViewTests.swift
//  PasswordTests
//
//  Created by Natália Sapucaia on 19/01/23.
//

import XCTest

@testable import Password

class PasswordStatusViewTests_ShowCheckmarkOrReset_When_Validation_Is_Inline: XCTestCase {

    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShort = "123Aa!"

    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = true // inline
    }

    /*
     if shouldResetCriteria {
         // Inline validation (✅ or ⚪️)
     } else {
         ...
     }
     */

    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage) // ✅
    }

    func testTooShort() throws {
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isResetImage) // ⚪️
    }
}

class PasswordStatusViewTests_ShowCheckmarkOrRedX_When_Validation_Is_Loss_Of_Focus: XCTestCase {

    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShort = "123Aa!"

    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = false
    }

    /*
     if shouldResetCriteria {
         ...
     } else {
         // Focus lost (✅ or ❌)
     }
     */

    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage)
        // 🕹 Ready Player1
    }

    func testTooShort() throws {
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isXmarkImage)
        // 🕹 Ready Player1
    }
}

class PasswordStatusViewTests_Validate_Number_of_Criteria: XCTestCase {
    var statusView: PasswordStatusView!

    let passwordWith2Criteria = "TestWith"
    let passwordWith3Criteria = "TesteWith3"
    let passwordWithAllCriteria = "TestWithAllCriteria1!"

    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
    }

    func testValidateTooShort() throws {
        XCTAssertFalse(statusView.validate("Ab12!"))
    }

    func testValidateWith2Criteria() throws {
        XCTAssertFalse(statusView.validate(passwordWith2Criteria))
    }

    func testValidateWith3Criteria() throws {
        XCTAssertTrue(statusView.validate(passwordWith3Criteria))
    }

    func testValidateWithAllCriteria() throws {
        XCTAssertTrue(statusView.validate(passwordWithAllCriteria))
    }
}
