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
}
