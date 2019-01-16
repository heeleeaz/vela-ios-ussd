//
//  VelaSDKTests.swift
//  VelaSDKTests
//
//  Created by Igbalajobi Elias on 12/8/18.
//  Copyright © 2018 Igbalajobi Elias. All rights reserved.
//

import XCTest
@testable import VelaSDK

class VelaSDKTests: XCTestCase {
    var appIdGenerator: AppIDGenerator!

    override func setUp() {
        super.setUp()
        
        appIdGenerator = AppIDGenerator()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        appIdGenerator = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let value = try? appIdGenerator.generateUniqueId(deviceImei: "3543130448382850", smsShortCode: "12345001")
        
        XCTAssertEqual(value!, "ZhD4mcSoCYo1")
//        XCTAssertEqual("a", "a")
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
