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
        let c = Color(r: -0.5, g: 0.4, b: 1.7)
        XCTAssert(c.r == -0.5)
        XCTAssert(c.g == 0.4)
        XCTAssert(c.b == 1.7)
    }
    
    func testAddingColors() {
        let c1 = Color(r: 0.9, g: 0.6, b: 0.75)
        let c2 = Color(r: 0.7, g: 0.1, b: 0.25)
        let expected = Color(r: 1.6, g: 0.7, b: 1.0)
        XCTAssert(c1 + c2 == expected)
    }
    
    func testSubtractingColors() {
        let c1 = Color(r: 0.9, g: 0.6, b: 0.75)
        let c2 = Color(r: 0.7, g: 0.1, b: 0.25)
        let expected = Color(r: 0.2, g: 0.5, b: 0.5)
        let difference = c1 - c2
        XCTAssert(difference ~= expected)
    }
    
    func testMultiplyingColorByScalar() {
        let c = Color(r: 0.2, g: 0.3, b: 0.4)
        let expected = Color(r: 0.4, g: 0.6, b: 0.8)
        XCTAssert(c * 2 == expected)
    }
    
    func testMultiplyingColors() {
        let c1 = Color(r: 1, g: 0.2, b: 0.4)
        let c2 = Color(r: 0.9, g: 1, b: 0.1)
        let expected = Color(r: 0.9, g: 0.2, b: 0.04)
        XCTAssert(c1 * c2 == expected)
    }

}
