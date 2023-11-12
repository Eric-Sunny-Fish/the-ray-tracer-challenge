//
//  CameraRendererTests.swift
//
//
//  Created by Eric Berna on 10/21/23.
//

import XCTest
@testable import TheRayTracerChallenge

final class CameraRendererTests: XCTestCase {
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
        let camera = Camera(hSize: 200, vSize: 125, fieldOfView: .pi / 2)
        let litColor = camera.lighting(
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
        let camera = Camera(hSize: 200, vSize: 125, fieldOfView: .pi / 2)
        let litColor = camera.lighting(
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
        let camera = Camera(hSize: 200, vSize: 125, fieldOfView: .pi / 2)
        let litColor = camera.lighting(
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
        let camera = Camera(hSize: 200, vSize: 125, fieldOfView: .pi / 2)
        let litColor = camera.lighting(
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
        let camera = Camera(hSize: 200, vSize: 125, fieldOfView: .pi / 2)
        let litColor = camera.lighting(
            material: material,
            light: light,
            position: position,
            eyeVector: eyeVector,
            normalVector: normalVector
        )
        let expected = Color(red: 0.1, green: 0.1, blue: 0.1)
        XCTAssertEqual(litColor, expected)
    }
    
    func testShadingIntersection() {
        let world = World.standard()
        let ray = Ray(origin: Tuple.point(0, 0, -5), direction: Tuple.vector(0, 0, 1))
        let intersections = ray.intersects(world: world)
        let shape = world.objects[0]
        let intersection = intersections.first { $0.time == 4 && $0.object == shape }
        guard let intersection else {
            XCTFail("Could not find intersection.")
            return
        }
        let camera = Camera(hSize: 200, vSize: 125, fieldOfView: .pi / 2)
        let color = camera.shadeHit(world: world, intersection: intersection)
        let expected = Color(red: 0.38066, green: 0.47583, blue: 0.2855)
        XCTAssertEqual(color, expected)
    }
    
    func testShadingInsideIntersection() {
        var world = World.standard()
        world.lights = [
            Light.point(
                position: Tuple.point(0, 0.25, -5),
                intensity: Color(red: 1, green: 1, blue: 1)
            )
        ]
        let ray = Ray(origin: Tuple.point(0, 0, 0), direction: Tuple.vector(0, 0, 1))
        let intersections = ray.intersects(world: world)
        let shape = world.objects[1]
        let intersection = intersections.first { $0.time == 0.5 && $0.object == shape }
        guard let intersection else {
            XCTFail("Could not find intersection.")
            return
        }
        let camera = Camera(hSize: 200, vSize: 125, fieldOfView: .pi / 2)
        let color = camera.shadeHit(world: world, intersection: intersection)
        // Once we add shadows this color changes.
        let expected = Color(red: 0.1, green: 0.1, blue: 0.1)
        XCTAssertEqual(color, expected)
    }
    
    func testShadePointInShadow() {
        let lights = [
            Light.point(
                position: Tuple.point(0, 0, -10),
                intensity: Color(red: 1, green: 1, blue: 1)
            )
        ]
        let spheres = [
            Sphere(),
            Sphere(transform: .translation(0, 0, 10))
        ]
        let world = World(objects: spheres, lights: lights)
        let ray = Ray(origin: Tuple.point(0, 0, 5), direction: Tuple.vector(0, 0, 1))
        let intersections = ray.intersects(world: world)
        let shape = world.objects[1]
        let intersection = intersections.first { $0.time == 4 && $0.object == shape }
        guard let intersection else {
            XCTFail("Could not find intersection.")
            return
        }
        let camera = Camera(hSize: 200, vSize: 125, fieldOfView: .pi / 2)
        let color = camera.shadeHit(world: world, intersection: intersection)
        let expected = Color(red: 0.1, green: 0.1, blue: 0.1)
        XCTAssertEqual(color, expected)
    }
    
    func testColorWhenRayMisses() {
        let world = World.standard()
        let ray = Ray(origin: Tuple.point(0, 0, -5), direction: Tuple.vector(0, 1, 0))
        let camera = Camera(hSize: 200, vSize: 125, fieldOfView: .pi / 2)
        let color = camera.color(world: world, ray: ray)
        let expected = Color(red: 0, green: 0, blue: 0)
        XCTAssertEqual(color, expected)
    }
    
    func testColorWhenHits() {
        let world = World.standard()
        let ray = Ray(origin: Tuple.point(0, 0, -5), direction: Tuple.vector(0, 0, 1))
        let camera = Camera(hSize: 200, vSize: 125, fieldOfView: .pi / 2)
        let color = camera.color(world: world, ray: ray)
        let expected = Color(red: 0.38066, green: 0.47583, blue: 0.2855)
        XCTAssertEqual(color, expected)
    }
    
    func testColorWhenHitsBehindRay() {
        var world = World.standard()
        world.objects[0].material.ambient = 1
        world.objects[1].material.ambient = 1
        let ray = Ray(origin: Tuple.point(0, 0, 0.75), direction: Tuple.vector(0, 0, -1))
        let camera = Camera(hSize: 200, vSize: 125, fieldOfView: .pi / 2)
        let color = camera.color(world: world, ray: ray)
        let expected = world.objects[1].material.color
        XCTAssertEqual(color, expected)
    }
    
    func testLightingWithSurfaceInShadow() {
        let eyeVector = Tuple.vector(0, 0, -1)
        let normalVector = Tuple.vector(0, 0, -1)
        let light = Light.point(position: Tuple.point(0, 0, -10), intensity: Color(red: 1, green: 1, blue: 1))
        let camera = Camera(hSize: 200, vSize: 125, fieldOfView: .pi / 2)
        let litColor = camera.lighting(
            material: material,
            light: light,
            position: position,
            eyeVector: eyeVector,
            normalVector: normalVector,
            inShadow: true
        )
        let expected = Color(red: 0.1, green: 0.1, blue: 0.1)
        XCTAssertEqual(litColor, expected)
    }
}
