//
//  GJIOSTests.swift
//  GJIOSTests
//
//  Created by Shurbhi Natani on 05/09/19.
//  Copyright © 2019 Surbhi Natani. All rights reserved.
//

import XCTest
@testable import GJIOS

class GJIOSTests: XCTestCase {

    var session : URLSession?
    
    override func setUp() {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        session = URLSession(configuration: .default)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        session = nil
        super.tearDown()
    }
    
    func testCheckContactInfo()
    {
        let urlString = AppConstants.BASE_URL+AppConstants.GET_CONTACTS
        
        var request : URLRequest = URLRequest(url: URL(string: urlString)!)
        
        request.httpMethod = HttpMethod.GET.rawValue
        
        request.timeoutInterval = 30
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let expectation = XCTestExpectation(description: "Expecting 200 stautus code")
        
        let dataTask =  session?.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse, let _ = data
                else {
                    XCTFail("Not a valid http response")
                    return
            }
            
            switch (httpResponse.statusCode)
            {
            case 200:
                
                expectation.fulfill()
                
            default:
                print("wallet GET request got response \(httpResponse.statusCode)")
            }
        }
        
        dataTask?.resume()
    }

}
