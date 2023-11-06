//
//  RendererTests.swift
//  
//
//  Created by Eric Berna on 10/21/23.
//

import XCTest
@testable import TheRayTracerChallenge

final class RendererTests: XCTestCase {
    private var material = Material()
    private var position = Tuple.point(0, 0, 0)
    
    override func setUpWithError() throws {
        material = Material()
        position = Tuple.point(0, 0, 0)
    }

    func testLightingEyeBetweenLightAndSurface() {
        let eyeVector = Tuple.vector(0, 0, -1)
        let normalVector = Tuple.vector(0, 0, -1)
        let light = Light.point(position: Tuple.point(0, 0, -10), intensity: Color(red: 1, green: 1, blue: 1))
        let litColor = Renderer.lighting(
            material: material,
            light: light,
            position: position,
            eyeVector: eyeVector,
            normalVector: normalVector
        )
        let expected = Color(red: 1.9, green: 1.9, blue: 1.9)
        XCTAssertEqual(litColor, expected)
    }
    
    func testLightingEyeOffsetBy45() {
        let eyeVector = Tuple.vector(0, sqrt(2) / 2, -sqrt(2) / 2)
        let normalVector = Tuple.vector(0, 0, -1)
        let light = Light.point(position: Tuple.point(0, 0, -10), intensity: Color(red: 1, green: 1, blue: 1))
        let litColor = Renderer.lighting(
            material: material,
            light: light,
            position: position,
            eyeVector: eyeVector,
            normalVector: normalVector
        )
        let expected = Color(red: 1.0, green: 1.0, blue: 1.0)
        XCTAssertEqual(litColor, expected)
    }
    
    func testLightingLightOffsetBy45() {
        let eyeVector = Tuple.vector(0, 0, -1)
        let normalVector = Tuple.vector(0, 0, -1)
        let light = Light.point(
            position: Tuple.point(0, 10, -10),
            intensity: Color(red: 1, green: 1, blue: 1)
        )
        let litColor = Renderer.lighting(
            material: material,
            light: light,
            position: position,
            eyeVector: eyeVector,
            normalVector: normalVector
        )
        let expected = Color(red: 0.7364, green: 0.7364, blue: 0.7364)
        XCTAssertEqual(litColor, expected)
    }

    func testLightingLookingAtReflection() {
        let eyeVector = Tuple.vector(0, -sqrt(2) / 2, -sqrt(2) / 2)
        let normalVector = Tuple.vector(0, 0, -1)
        let light = Light.point(
            position: Tuple.point(0, 10, -10),
            intensity: Color(red: 1, green: 1, blue: 1)
        )
        let litColor = Renderer.lighting(
            material: material,
            light: light,
            position: position,
            eyeVector: eyeVector,
            normalVector: normalVector
        )
        let expected = Color(red: 1.6364, green: 1.6364, blue: 1.6364)
        XCTAssertEqual(litColor, expected)
    }
    
    func testLightingLightBehindSurface() {
        let eyeVector = Tuple.vector(0, 0, -1)
        let normalVector = Tuple.vector(0, 0, -1)
        let light = Light.point(position: Tuple.point(0, 0, 10), intensity: Color(red: 1, green: 1, blue: 1))
        let litColor = Renderer.lighting(
            material: material,
            light: light,
            position: position,
            eyeVector: eyeVector,
            normalVector: normalVector
        )
        let expected = Color(red: 0.1, green: 0.1, blue: 0.1)
        XCTAssertEqual(litColor, expected)
    }
}
