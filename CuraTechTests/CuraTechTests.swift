//
//  CuraTechTests.swift
//  CuraTechTests
//
//  Created by Bhumika tripathi on 8/11/18.
//  Copyright © 2018 Bhumika tripathi. All rights reserved.
//

import XCTest
@testable import CuraTech

class CuraTechTests: XCTestCase {
    
    var checkJsonFile: ParseJson!
    var checkQuestionType: AddQuestionTest!
    override func setUp() {
        super.setUp()
        checkJsonFile = ParseJson()
        checkQuestionType = AddQuestionTest()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        checkQuestionType = nil
    }
    
    func testTheValidationofJsonFile() {
        
        //1. test the file -> this file will pass the case
        checkJsonFile.ParseJsonFile(fileName: "Answers") { (dict) in
            XCTAssertTrue(true)

        }
        //2. test the file -> this file generate the error as there is no such file

        checkJsonFile.ParseJsonFile(fileName: "error") { (dict) in
            XCTAssertTrue(false)
            
        }

    }
    
    
    func testValidationOfDatatypeSupportedByQuestion()
    {
        checkQuestionType.testQuestionType(type: "radio")
        
    }
    
    func testPerformanceExample() {
        // This is used to measure the time passed during the test.
        self.measure {
        }
    }
    
}
