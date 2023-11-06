//
//  ObjectTests.swift
//  
//
//  Created by Eric Berna on 10/21/23.
//

import XCTest
@testable import TheRayTracerChallenge

final class ObjectTests: XCTestCase {
    func testSpheresHaveDefaultTransforms() {
        let sphere = Sphere()
        XCTAssertEqual(sphere.transform, Matrix.identity)
    }
    
    func testShereTransformsCanChange() {
        var sphere = Sphere()
        let translation = Matrix.translation(2, 3, 4)
        sphere.transform = translation
        XCTAssertEqual(sphere.transform, translation)
    }
    
    func testNormalOnSphereAtPointOnXAxis() {
        let sphere = Sphere()
        let normal = sphere.normal(at: Tuple.point(1, 0, 0))
        let expected = Tuple.vector(1, 0, 0)
        XCTAssertEqual(normal, expected)
    }
    
    func testNormalOnSphereAtPointOnYAxis() {
        let sphere = Sphere()
        let normal = sphere.normal(at: Tuple.point(0, 1, 0))
        let expected = Tuple.vector(0, 1, 0)
        XCTAssertEqual(normal, expected)
    }

    func testNormalOnSphereAtPointOnZAxis() {
        let sphere = Sphere()
        let normal = sphere.normal(at: Tuple.point(0, 0, 1))
        let expected = Tuple.vector(0, 0, 1)
        XCTAssertEqual(normal, expected)
    }

    func testNormalOnSphereAtPointOffAxis() {
        let sphere = Sphere()
        let normal = sphere.normal(at: Tuple.point(3, 3, 3).unit)
        let expected = Tuple.vector(sqrt(3) / 3, sqrt(3) / 3, sqrt(3) / 3)
        XCTAssertEqual(normal, expected)
    }
    
    func testNormalIsNormalized() {
        let sphere = Sphere()
        let normal = sphere.normal(at: Tuple.point(3, 3, 3).unit)
        let expected = normal.unit
        XCTAssertEqual(normal, expected)
    }
    
    func testNormalOnTranslatedSphere() {
        let sphere = Sphere(transform: .translation(0, 1, 0))
        let normal = sphere.normal(at: Tuple.point(0, 1.70711, -0.70711))
        let expected = Tuple.vector(0, 0.70711, -0.70711)
        XCTAssertEqual(normal, expected)
    }
    
    func testNormalOnTransformedSphere() {
        let sphere = Sphere(transform: .scale(1, 0.5, 1) * .rotationZ(.pi / 5))
        let normal = sphere.normal(at: Tuple.point(0, sqrt(2) / 2, -sqrt(2) / 2))
        let expected = Tuple.vector(0, 0.97014, -0.24254)
        XCTAssertEqual(normal, expected)
    }
    
    func testSphereHasDefaultMaterial() {
        let sphere = Sphere()
        let expected = Material()
        XCTAssertEqual(sphere.material, expected)
    }
    
    func testSphereHasAssignedMaterial() {
        let material = Material(ambient: 1)
        let sphere = Sphere(material: material)
        XCTAssertEqual(sphere.material, material)
    }
}
