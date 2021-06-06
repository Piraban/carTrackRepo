//
//  LoginViewModelTests.swift
//  CarTrackPirabaTests
//
//  Created by Piraba Nagkeeran on 6/6/21.
//

import XCTest
@testable import CarTrackPiraba

class LoginViewModelTests: XCTestCase {
    var loginVM : LoginViewModel = LoginViewModel()
    
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
    
    func testCountries() {
        loginVM.fetchCountries()
        let countries = loginVM.countries
        XCTAssertEqual(countries.count == 10, false)
    }

    
    func testCountriesCount() {
        loginVM.fetchCountries()
        let countries = loginVM.countries
        XCTAssertEqual(countries.count == 20, false)
    }
    
    
    func testIsValidUser() {
        loginVM.isValidAuthUser(username: "abcd", userPas: "1234567", country: "Singapore")
        XCTAssertEqual(loginVM.isLoginSuccess == LoginStatus.loggedIn, true)
    }
    
    func testIsValidUserForFail() {
        loginVM.isValidAuthUser(username: "acdfsf", userPas: "454354", country: "Singapore")
        XCTAssertEqual(loginVM.isLoginSuccess == LoginStatus.loginFail, true)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
