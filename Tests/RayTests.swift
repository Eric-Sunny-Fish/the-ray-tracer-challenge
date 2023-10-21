//
//  RayTests.swift
//  
//
//  Created by Eric Berna on 10/17/23.
//

import XCTest
@testable import TheRayTracerChallenge

final class RayTests: XCTestCase {
    func testCreatingRay() {
        let origin = Tuple.point(1, 2, 3)
        let direction = Tuple.vector(4, 5, 6)
        let ray = Ray(origin: origin, direction: direction)
        XCTAssertEqual(ray.origin, origin)
        XCTAssertEqual(ray.direction, direction)
    }
    
    func testPointFromDistance() {
        let ray = Ray(origin: Tuple.point(2, 3, 4), direction: Tuple.vector(1, 0, 0))
        var expected = Tuple.point(2, 3, 4)
        var position = ray.position(time: 0)
        XCTAssertEqual(position, expected)
        expected = Tuple.point(3, 3, 4)
        position = ray.position(time: 1)
        XCTAssertEqual(position, expected)
        expected = Tuple.point(1, 3, 4)
        position = ray.position(time: -1)
        XCTAssertEqual(position, expected)
        expected = Tuple.point(4.5, 3, 4)
        position = ray.position(time: 2.5)
        XCTAssertEqual(position, expected)
    }
    
    func testRayIntersectsSphereAtTwoPoints() {
        let ray = Ray(origin: Tuple.point(0, 0, -5), direction: Tuple.vector(0, 0, 1))
        let sphere = Sphere()
        let intersections = ray.intersects(sphere)
        XCTAssertEqual(intersections.count, 2)
        XCTAssertEqual(intersections[0].time, 4.0)
        XCTAssertEqual(intersections[1].time, 6.0)
    }
    
    func testRayIntersectsSphereAtTanget() {
        let ray = Ray(origin: Tuple.point(0, 1, -5), direction: Tuple.vector(0, 0, 1))
        let sphere = Sphere()
        let intersections = ray.intersects(sphere)
        XCTAssertEqual(intersections.count, 2)
        XCTAssertEqual(intersections[0].time, 5.0)
        XCTAssertEqual(intersections[1].time, 5.0)
    }
    
    func testRayMissesSphere() {
        let ray = Ray(origin: Tuple.point(0, 2, -5), direction: Tuple.vector(0, 0, 1))
        let sphere = Sphere()
        let intersections = ray.intersects(sphere)
        XCTAssertEqual(intersections.count, 0)
    }
    
    func testRayOriginatesInsideSphere() {
        let ray = Ray(origin: Tuple.point(0, 0, 0), direction: Tuple.vector(0, 0, 1))
        let sphere = Sphere()
        let intersections = ray.intersects(sphere)
        XCTAssertEqual(intersections.count, 2)
        XCTAssertEqual(intersections[0].time, -1.0)
        XCTAssertEqual(intersections[1].time, 1.0)
    }
    
    func testSphereIsBehindRay() {
        let ray = Ray(origin: Tuple.point(0, 0, 5), direction: Tuple.vector(0, 0, 1))
        let sphere = Sphere()
        let intersections = ray.intersects(sphere)
        XCTAssertEqual(intersections.count, 2)
        XCTAssertEqual(intersections[0].time, -6.0)
        XCTAssertEqual(intersections[1].time, -4.0)
    }
    
    func testIntersectionHasObject() {
        let ray = Ray(origin: Tuple.point(0, 0, -5), direction: Tuple.vector(0, 0, 1))
        let sphere = Sphere()
        let intersections = ray.intersects(sphere)
        XCTAssertEqual(intersections.count, 2)
        XCTAssertEqual(intersections[0].object, sphere)
        XCTAssertEqual(intersections[1].object, sphere)
    }
    
    func testTranslatingRay() {
        let ray = Ray(origin: Tuple.point(1, 2, 3), direction: Tuple.vector(0, 1, 0))
        let matrix = Matrix.translation(3, 4, 5)
        let ray2 = ray.transform(by: matrix)
        let expected = Ray(origin: Tuple.point(4, 6, 8), direction: Tuple.vector(0, 1, 0))
        XCTAssertEqual(ray2, expected)
    }
    
    func testScalingRay() {
        let ray = Ray(origin: Tuple.point(1, 2, 3), direction: Tuple.vector(0, 1, 0))
        let matrix = Matrix.scale(2, 3, 4)
        let ray2 = ray.transform(by: matrix)
        let expected = Ray(origin: Tuple.point(2, 6, 12), direction: Tuple.vector(0, 3, 0))
        XCTAssertEqual(ray2, expected)
    }
}
