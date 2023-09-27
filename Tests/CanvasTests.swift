//
//  CanvasTests.swift
//  The Ray Tracer ChallengeTests
//
//  Created by Eric Berna on 9/22/23.
//

import XCTest
@testable import The_Ray_Tracer_Challenge

final class CanvasTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreatingCanvas() {
        let c = Canvas(width: 10, height: 20)
        XCTAssert(c.width == 10)
        XCTAssert(c.height == 20)
        let black = Color(r: 0, g: 0, b: 0)
        for x in 0..<c.width {
            for y in 0..<c.height {
                XCTAssert(c.pixel(x: x, y: y) == black)
            }
        }
    }
    
    func testWritePixelToCanvas() {
        var c = Canvas(width: 10, height: 20)
        let red = Color(r: 1, g: 0, b: 0)
        c.write(x: 2, y: 3, color: red)
        XCTAssert(c.pixel(x: 2, y: 3) == red)
    }

    func testConstructingThePPMHeader() {
        let c = Canvas(width: 5, height: 3)
        let ppm = c.ppm()
        var lines = [String]()
        ppm.enumerateLines { line, stop in
            lines.append(line)
        }
        XCTAssert(lines[0] == "P3")
        XCTAssert(lines[1] == "5 3")
        XCTAssert(lines[2] == "255")
    }
    
    func testConstructingPPMData() {
        var c = Canvas(width: 5, height: 3)
        let c1 = Color(r: 1.5, g: 0, b: 0)
        let c2 = Color(r: 0, g: 0.5, b: 0)
        let c3 = Color(r: -0.5, g: 0, b: 1)
        c.write(x: 0, y: 0, color: c1)
        c.write(x: 2, y: 1, color: c2)
        c.write(x: 4, y: 2, color: c3)
        let ppm = c.ppm()
        var lines = [String]()
        ppm.enumerateLines { line, stop in
            lines.append(line)
        }
        XCTAssert(lines[3] == "255 0 0 0 0 0 0 0 0 0 0 0 0 0 0", "Line 3: \(lines[3])")
        XCTAssert(lines[4] == "0 0 0 0 0 0 0 127 0 0 0 0 0 0 0", "Line 4: \(lines[4])")
        XCTAssert(lines[5] == "0 0 0 0 0 0 0 0 0 0 0 0 0 0 255", "Line 5: \(lines[5])")
    }
    
    func testSplittingLongLinesInPPMFiles() {
        var c = Canvas(width: 10, height: 2)
        let color = Color(r: 1, g: 0.8, b: 0.6)
        for x in 0..<c.width {
            for y in 0..<c.height {
                c.write(x: x, y: y, color: color)
            }
        }
        let ppm = c.ppm()
        var lines = [String]()
        ppm.enumerateLines { line, stop in
            lines.append(line)
        }
        XCTAssert(lines[3] == "255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204", "Line 3: \(lines[3])")
        XCTAssert(lines[4] == "153 255 204 153 255 204 153 255 204 153 255 204 153", "Line 4: \(lines[4])")
        XCTAssert(lines[5] == "255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204", "Line 5: \(lines[5])")
        XCTAssert(lines[6] == "153 255 204 153 255 204 153 255 204 153 255 204 153", "Line 6: \(lines[6])")
    }
    
    func testPPMFilesAreTerminatedByANewLineCharacter() {
        let c = Canvas(width: 5,height: 3)
        let ppm = c.ppm()
        if let last = ppm.last {
            XCTAssert(last == "\n")
        }
    }

}
