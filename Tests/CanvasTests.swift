//
//  CanvasTests.swift
//  The Ray Tracer ChallengeTests
//
//  Created by Eric Berna on 9/22/23.
//

import XCTest
@testable import TheRayTracerChallenge

final class CanvasTests: XCTestCase {
    func testCreatingCanvas() {
        let canvas = Canvas(width: 10, height: 20)
        XCTAssertEqual(canvas.width, 10)
        XCTAssertEqual(canvas.height, 20)
        let black = Color(red: 0, green: 0, blue: 0)
        for x in 0..<canvas.width {
            for y in 0..<canvas.height {
                XCTAssertEqual(canvas.pixel(x: x, y: y), black)
            }
        }
    }
    
    func testWritePixelToCanvas() {
        var canvas = Canvas(width: 10, height: 20)
        let red = Color(red: 1, green: 0, blue: 0)
        canvas.write(x: 2, y: 3, color: red)
        XCTAssertEqual(canvas.pixel(x: 2, y: 3), red)
    }

    func testConstructingThePPMHeader() {
        let canvas = Canvas(width: 5, height: 3)
        let ppm = canvas.ppm()
        var lines = [String]()
        ppm.enumerateLines { line, _ in
            lines.append(line)
        }
        XCTAssertEqual(lines[0], "P3")
        XCTAssertEqual(lines[1], "5 3")
        XCTAssertEqual(lines[2], "255")
    }
    
    func testConstructingPPMData() {
        var canvas = Canvas(width: 5, height: 3)
        let color1 = Color(red: 1.5, green: 0, blue: 0)
        let color2 = Color(red: 0, green: 0.5, blue: 0)
        let color3 = Color(red: -0.5, green: 0, blue: 1)
        canvas.write(x: 0, y: 0, color: color1)
        canvas.write(x: 2, y: 1, color: color2)
        canvas.write(x: 4, y: 2, color: color3)
        let ppm = canvas.ppm()
        var lines = [String]()
        ppm.enumerateLines { line, _ in
            lines.append(line)
        }
        XCTAssertEqual(lines[3], "255 0 0 0 0 0 0 0 0 0 0 0 0 0 0", "Line 3: \(lines[3])")
        XCTAssertEqual(lines[4], "0 0 0 0 0 0 0 127 0 0 0 0 0 0 0", "Line 4: \(lines[4])")
        XCTAssertEqual(lines[5], "0 0 0 0 0 0 0 0 0 0 0 0 0 0 255", "Line 5: \(lines[5])")
    }
    
    func testSplittingLongLinesInPPMFiles() {
        var canvas = Canvas(width: 10, height: 2)
        let color = Color(red: 1, green: 0.8, blue: 0.6)
        for x in 0..<canvas.width {
            for y in 0..<canvas.height {
                canvas.write(x: x, y: y, color: color)
            }
        }
        let ppm = canvas.ppm()
        var lines = [String]()
        ppm.enumerateLines { line, _ in
            lines.append(line)
        }
        XCTAssertEqual(
            lines[3],
            "255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204",
            "Line 3: \(lines[3])"
        )
        XCTAssertEqual(
            lines[4], 
            "153 255 204 153 255 204 153 255 204 153 255 204 153",
            "Line 4: \(lines[4])"
        )
        XCTAssertEqual(
            lines[5], 
            "255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204",
            "Line 5: \(lines[5])"
        )
        XCTAssertEqual(
            lines[6],
            "153 255 204 153 255 204 153 255 204 153 255 204 153",
            "Line 6: \(lines[6])"
        )
    }
    
    func testPPMFilesAreTerminatedByANewLineCharacter() {
        let canvas = Canvas(width: 5, height: 3)
        let ppm = canvas.ppm()
        if let last = ppm.last {
            XCTAssertEqual(last, "\n")
        }
    }
}
