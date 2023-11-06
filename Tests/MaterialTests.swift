//
//  MaterialTests.swift
//  
//
//  Created by Eric Berna on 10/21/23.
//

import XCTest
@testable import TheRayTracerChallenge

final class MaterialTests: XCTestCase {
    func testDefaultMaterial() {
        let material = Material()
        XCTAssertEqual(material.color, Color(red: 1, green: 1, blue: 1))
        XCTAssertEqual(material.ambient, 0.1)
        XCTAssertEqual(material.diffuse, 0.9)
        XCTAssertEqual(material.specular, 0.9)
        XCTAssertEqual(material.shininess, 200)
    }
}
