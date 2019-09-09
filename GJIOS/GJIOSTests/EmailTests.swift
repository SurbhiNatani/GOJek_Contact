//
//  EmailTests.swift
//  GJIOSTests
//
//  Created by Shurbhi Natani on 09/09/19.
//  Copyright © 2019 Surbhi Natani. All rights reserved.
//

import XCTest
@testable import GJIOS

class EmailTests: XCTestCase {
    
    var profile: EditProfileVC!
    
    override func setUp() {
        profile = EditProfileVC()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testForValidEmail() {
        let email = "test@testingemail.com"
        
        let checker = email.isValidEmail
        
        XCTAssertTrue(checker)
    }
    
    func testForInvalidEmail() {
        let email = "gsdfgfdg5fd1g5f"
        
        let checker = email.isValidEmail 
        
        XCTAssertFalse(checker)
    }
    
    func testForLowercaseEmailConversion() {
        let email = "JoHnnyPerdoMO@GmaIL.cOm"
        
        let lowerCasedEmail = email.lowercased()
        
        XCTAssertEqual(lowerCasedEmail, "johnnyperdomo@gmail.com")
    }
    
    func testForUpperCaseEmail() {
        let email = "teSterUnit@gMAil.cOM"
        
        let lowerCasedEmail = email.lowercased()
        
        XCTAssertNotEqual(lowerCasedEmail, email)
    }
    
    func testForIncompleteEmail() {
        let email = "incomplete@gmail"
        
        let checker = email.isValidEmail
        
        XCTAssertFalse(checker)
    }
    
    func testForEmailNoName() {
        let email = "@gmail.com"
        
        let checker = email.isValidEmail
        
        XCTAssertFalse(checker)
    }
    
    func testForEmailNoDomain() {
        let email = "johnnytest@"
        
        let checker = email.isValidEmail
        
        XCTAssertFalse(checker)
    }
    
    func testForWhiteSpacesInEmail() {
        let email = "eleven@stranger things.com"
        
        let checker = email.isValidEmail
        
        XCTAssertFalse(checker)
    }
}
