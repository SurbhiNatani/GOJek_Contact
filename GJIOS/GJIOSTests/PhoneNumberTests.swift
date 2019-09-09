//
//  PhoneNumberTests.swift
//  GJIOSTests
//
//  Created by Shurbhi Natani on 09/09/19.
//  Copyright © 2019 Surbhi Natani. All rights reserved.
//

import XCTest
@testable import GJIOS

class PhoneNumberTests: XCTestCase {
    
    var profile: EditProfileVC!
    
    override func setUp() {
        profile = EditProfileVC()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testForValidPhoneNumber() {
        let number = "3115552368"
        
        let checker = number.isValidPhone
        
        XCTAssertTrue(checker)
    }
    
    func testForLettersInPhoneNumber() {
        let number = "3115552hj8"
        
        let checker = number.isValidPhone
        
        XCTAssertFalse(checker)
    }
    
    func testWhetherCharacterCountInNumberIsLessThan10() {
        let number = "132153"
        let number9 = "123456789"
        
        let checker = number.isValidPhone
        let checker9 = number9.isValidPhone
        
        XCTAssertFalse(checker, "Number count should be 10")
        XCTAssertFalse(checker9, "Number count should be 10")
    }
    
    func testWhetherCharactersCountInNumberIsMoreThan10() {
        let number10 = "1234567891"
        let number11 = "12345678911"
        
        let checker1 = number10.isValidPhone
        let checker2 = number11.isValidPhone
        
        XCTAssertTrue(checker1, "10 characters should be allowed in a phone number. Phone Number should be true")
        XCTAssertFalse(checker2, "10 characters should be the max in a phone number, you currently have \(number11.count) characters. Phone Number should be false")
    }
    
    func testForMultipleInvalidCharactersInNumber() {
        let number = "+++++++*+9"
        
        let checker = number.isValidPhone
        
        XCTAssertFalse(checker)
        
    }
}
