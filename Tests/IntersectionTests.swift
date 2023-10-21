//
//  IntersectionTests.swift
//
//
//  Created by Eric Berna on 10/19/23.
//

import XCTest
@testable import TheRayTracerChallenge

final class IntersectionTests: XCTestCase {
    func testIntersectionEncapsulatesTimeAndObject() {
        let sphere = Sphere()
        let intersection = Intersection(time: 3.5, object: sphere)
        XCTAssertEqual(intersection.time, 3.5)
        XCTAssertEqual(intersection.object, sphere)
    }
    
    func testAggregatingIntersections() {
        let sphere = Sphere()
        let intersection1 = Intersection(time: 1, object: sphere)
        let intersection2 = Intersection(time: 2, object: sphere)
        let intersections = Intersection.intersections(intersection1, intersection2)
        XCTAssertEqual(intersections.count, 2)
        XCTAssertEqual(intersections[0].time, 1)
        XCTAssertEqual(intersections[1].time, 2)
    }
    
    func testHitForPositiveTimes() {
        let sphere = Sphere()
        let intersection1 = Intersection(time: 1, object: sphere)
        let intersection2 = Intersection(time: 2, object: sphere)
        let intersections = Intersection.intersections(intersection1, intersection2)
        let hit = intersections.hit()
        XCTAssertEqual(intersection1, hit)
    }
    
    func testHitForPositiveAndNegativeTimes() {
        let sphere = Sphere()
        let intersection1 = Intersection(time: -1, object: sphere)
        let intersection2 = Intersection(time: 1, object: sphere)
        let intersections = Intersection.intersections(intersection1, intersection2)
        let hit = intersections.hit()
        XCTAssertEqual(intersection2, hit)
    }
    
    func testHitForNegativeTimes() {
        let sphere = Sphere()
        let intersection1 = Intersection(time: -2, object: sphere)
        let intersection2 = Intersection(time: -1, object: sphere)
        let intersections = Intersection.intersections(intersection1, intersection2)
        let hit = intersections.hit()
        XCTAssertNil(hit)
    }
    
    func testHitTheLowestNonnegativeIntersection() {
        let sphere = Sphere()
        let intersection1 = Intersection(time: 5, object: sphere)
        let intersection2 = Intersection(time: 7, object: sphere)
        let intersection3 = Intersection(time: -3, object: sphere)
        let intersection4 = Intersection(time: 2, object: sphere)
        let intersections = Intersection.intersections(
            intersection1,
            intersection2,
            intersection3,
            intersection4
        )
        let hit = intersections.hit()
        XCTAssertEqual(hit, intersection4)
    }
    
    func testIntersectScaledSphere() {
        let ray = Ray(origin: Tuple.point(0, 0, -5), direction: Tuple.vector(0, 0, 1))
        let sphere = Sphere(transform: .scale(2, 2, 2))
        let intersections = ray.intersects(sphere)
        XCTAssertEqual(intersections.count, 2)
        XCTAssertEqual(intersections[0].time, 3)
        XCTAssertEqual(intersections[1].time, 7)
    }
    
    func testIntersectTranslatedSphere() {
        let ray = Ray(origin: Tuple.point(0, 0, -5), direction: Tuple.vector(0, 0, 1))
        let sphere = Sphere(transform: .translation(5, 0, 0))
        let intersections = ray.intersects(sphere)
        XCTAssertEqual(intersections.count, 0)
    }
}
