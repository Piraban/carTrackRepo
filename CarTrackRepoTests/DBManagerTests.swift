//
//  DBManagerTests.swift
//  CarTrackPirabaTests
//
//  Created by Piraba Nagkeeran on 6/6/21.
//

import XCTest
@testable import CarTrackPiraba

class DBManagerTests: XCTestCase {
    
    override func setUpWithError() throws {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testCreateTable() throws {
        DBManagerImpl().createAuthUser()
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testGetUser() throws {
        let result = DBManagerImpl().isAuthUserExist(userName: "abcd", userPassword: "1234567", countryName: "Singapore")
        XCTAssertEqual(result, true)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testGetUserNoExist() throws {
        let result = DBManagerImpl().isAuthUserExist(userName: "test", userPassword: "232323", countryName: "Singapore")
        XCTAssertEqual(result, false)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
