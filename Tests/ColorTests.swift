//
//  ColorTests.swift
//  The Ray Tracer ChallengeTests
//
//  Created by Eric Berna on 9/21/23.
//

import XCTest
@testable import TheRayTracerChallenge

final class ColorTests: XCTestCase {
    func testColor() throws {
        let color = Color(red: -0.5, green: 0.4, blue: 1.7)
        XCTAssertEqual(color.red, -0.5)
        XCTAssertEqual(color.green, 0.4)
        XCTAssertEqual(color.blue, 1.7)
    }
    
    func testAddingColors() {
        let color1 = Color(red: 0.9, green: 0.6, blue: 0.75)
        let color2 = Color(red: 0.7, green: 0.1, blue: 0.25)
        let expected = Color(red: 1.6, green: 0.7, blue: 1.0)
        XCTAssertEqual(color1 + color2, expected)
    }
    
    func testSubtractingColors() {
        let color1 = Color(red: 0.9, green: 0.6, blue: 0.75)
        let color2 = Color(red: 0.7, green: 0.1, blue: 0.25)
        let expected = Color(red: 0.2, green: 0.5, blue: 0.5)
        let difference = color1 - color2
        XCTAssert(difference ~= expected)
    }
    
    func testMultiplyingColorByScalar() {
        let color = Color(red: 0.2, green: 0.3, blue: 0.4)
        let expected = Color(red: 0.4, green: 0.6, blue: 0.8)
        XCTAssertEqual(color * 2, expected)
    }
    
    func testMultiplyingColors() {
        let color1 = Color(red: 1, green: 0.2, blue: 0.4)
        let color2 = Color(red: 0.9, green: 1, blue: 0.1)
        let expected = Color(red: 0.9, green: 0.2, blue: 0.04)
        XCTAssertEqual(color1 * color2, expected)
    }
}
