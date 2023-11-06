//
//  LightTests.swift
//  
//
//  Created by Eric Berna on 10/21/23.
//

import XCTest
@testable import TheRayTracerChallenge

final class LightTests: XCTestCase {
    func testPointLightHasPositionAndIntensity() {
        let intensity = Color(red: 1, green: 1, blue: 1)
        let position = Tuple.point(0, 0, 0)
        let light = Light.point(position: position, intensity: intensity)
        XCTAssertEqual(light.position, position)
        XCTAssertEqual(light.intensity, intensity)
    }
}
