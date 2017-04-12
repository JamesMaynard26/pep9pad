//
//  pep9padTests.swift
//  pep9padTests
//
//  Copyright © 2016 Pepperdine University. All rights reserved.
//

import XCTest
@testable import pep9pad

class pep9padTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        assembler.installDefaultOS()
        for i in Figures.allValues where !i.rawValue.contains("Figure 4") {
            var name = i.rawValue
            // change name to look like those in the filesystem
            name = name.replacingOccurrences(of: "Figure ", with: "fig0")
            name = name.replacingOccurrences(of: ".", with: "")
            let pathToSource = Bundle.main.path(forResource: name, ofType: "pep")
            let pathToObject = Bundle.main.path(forResource: name, ofType: "pepo")
            
            do {
                let sourceStr = try String(contentsOfFile:pathToSource!, encoding: String.Encoding.ascii)
                let objectStr = try String(contentsOfFile:pathToObject!, encoding: String.Encoding.ascii).replacingOccurrences(of: "zz", with: "")
                var correctObject = objectStr.components(separatedBy: [" ", "\n"])
                projectModel.sourceStr = sourceStr
                if assembler.assemble() {
                    var anObject: [Int] = []
                    var toRet = ""
                    var listing = ""
                    var error = false
                    for i in 0..<assembler.source.count {
                        assembler.source[i].appendObjectCode(objectCode: &anObject)
                    }
                    
                    for j in 0..<anObject.count {
                        let hex = anObject[j].toHex2()
                        if hex == correctObject[j] {
                            toRet.append(hex)
                        } else {
                            toRet.append("[\(hex) -> \(correctObject[j])]")
                            error = true
                        }
                        toRet.append((j % 16) == 15 ? "\n" : " ")
                    }
                    
                    if error {
                        listing = assembler.getReadableListing()
                    }
                    
                    print(error ? "Error detected in \(name)." : "Correctly assembled \(name).")
                    print(error ? toRet+"\n"+listing : "")
                } else {
                    XCTAssert(false)
                }
                
                
                
                
            } catch _ as NSError {
                print("Could not load project.")
                continue
            }
            
        }
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
