// UserDefaultsTests.swift
//
// Copyright (C) 2016 Subito.it S.r.l (www.subito.it)
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import SBTUITestTunnel
import Foundation

class UserDefaultsTest: XCTestCase {

    override func setUp() {
        super.setUp()
                
        app.launchTunnel(withOptions: [SBTUITunneledApplicationLaunchOptionResetFilesystem])
        
        expectation(for: NSPredicate(format: "count > 0"), evaluatedWith: app.tables)
        waitForExpectations(timeout: 15.0, handler: nil)
        
        Thread.sleep(forTimeInterval: 1.0)
    }
    
    func testUserDefaults() {
        let randomString = ProcessInfo.processInfo.globallyUniqueString
        
        let userDefaultKey = "test_key"
        // add and retrieve random string
        XCTAssertTrue(app.userDefaultsSetObject(randomString as NSCoding & NSObjectProtocol, forKey: userDefaultKey))
        XCTAssertEqual(randomString, app.userDefaultsObject(forKey: userDefaultKey) as! String)
        
        // remove and check for nil
        XCTAssertTrue(app.userDefaultsRemoveObject(forKey:userDefaultKey))
        XCTAssertNil(app.userDefaultsObject(forKey: userDefaultKey))
        
        // add again, remove all keys and check for nil item
        XCTAssertTrue(app.userDefaultsSetObject(randomString as NSCoding & NSObjectProtocol, forKey: userDefaultKey))
        app.userDefaultsReset()
        XCTAssertNil(app.userDefaultsObject(forKey: userDefaultKey))
    }
}
