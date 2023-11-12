//
//  WorldTests.swift
//  
//
//  Created by Eric Berna on 11/6/23.
//

import XCTest
@testable import TheRayTracerChallenge

final class WorldTests: XCTestCase {
    func testCreatingWord() {
        let world = World()
        XCTAssertTrue(world.objects.isEmpty)
        XCTAssertTrue(world.lights.isEmpty)
    }
    
    // Default is a keyword, so I'm using standard instead.
    func testStandardWorld() {
        let standard = World.standard()
        let light = Light.point(
            position: Tuple.point(-10, 10, -10),
            intensity: Color(red: 1, green: 1, blue: 1)
        )
        let sphere1 = Sphere(
            material: Material(color: Color(red: 0.8, green: 1.0, blue: 0.6), diffuse: 0.7, specular: 0.2)
        )
        let sphere2 = Sphere(transform: Matrix.scale(0.5, 0.5, 0.5))
        XCTAssertEqual(standard.lights[0], light)
        XCTAssertNotNil(standard.objects.first { item in
            item == sphere1
        })
        XCTAssertNotNil(standard.objects.first { item in
            item == sphere2
        })
    }
    
    func testOffToSideIsNotShadowed() {
        let world = World.standard()
        let point = Tuple.point(0, 10, 0)
        XCTAssertFalse(world.isShadowed(point: point))
    }
    
    func testBehindIsShadowed() {
        let world = World.standard()
        let point = Tuple.point(10, -10, 10)
        XCTAssertTrue(world.isShadowed(point: point))
    }
    
    func testOtherSideOfLightIsNotShadowed() {
        let world = World.standard()
        let point = Tuple.point(-20, 20, -20)
        XCTAssertFalse(world.isShadowed(point: point))
    }
    
    func testBetweenIsShadowed() {
        let world = World.standard()
        let point = Tuple.point(-2, 2, -2)
        XCTAssertFalse(world.isShadowed(point: point))
    }
}
