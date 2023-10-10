//
//  TransformationsTests.swift
//  
//
//  Created by Eric Berna on 10/8/23.
//

import XCTest
@testable import TheRayTracerChallenge

final class TransformationsTests: XCTestCase {
    func testMultiplyingByTranslationMatrix() {
        let transform = Matrix.translation(5, -3, 2)
        let point = Tuple.point(-3, 4, 5)
        let transformed = transform * point
        let expected = Tuple.point(2, 1, 7)
        XCTAssertEqual(transformed, expected)
    }
    
    func testMultiplyingByTranslationMatrixInverse() {
        let transform = Matrix.translation(5, -3, 2)
        guard let transformInverse = transform.inverse else {
            XCTFail("Could not invert matrix")
            return
        }
        let point = Tuple.point(-3, 4, 5)
        let transformed = transformInverse * point
        let expected = Tuple.point(-8, 7, 3)
        XCTAssertEqual(transformed, expected)
    }
    
    func testTranslationDoesNotAffectVectors() {
        let transform = Matrix.translation(5, -3, 2)
        let vector = Tuple.vector(-3, 4, 5)
        let translated = transform * vector
        XCTAssertEqual(translated, vector)
    }
    
    func testMultiplyingPointByScalingMatrix() {
        let transform = Matrix.scale(2, 3, 4)
        let point = Tuple.point(-4, 6, 8)
        let expected = Tuple.point(-8, 18, 32)
        let scaled = transform * point
        XCTAssertEqual(scaled, expected)
    }
    
    func testMultiplyingVectorByScalingMatrix() {
        let transform = Matrix.scale(2, 3, 4)
        let vector = Tuple.vector(-4, 6, 8)
        let expected = Tuple.vector(-8, 18, 32)
        let scaled = transform * vector
        XCTAssertEqual(scaled, expected)
    }
    
    func testMultiplyingByScalingMatrixInverse() {
        let transform = Matrix.scale(2, 3, 4)
        guard let inverse = transform.inverse else {
            XCTFail("Could not make inverse.")
            return
        }
        let vector = Tuple.vector(-4, 6, 8)
        let expected = Tuple.vector(-2, 2, 2)
        let scaled = inverse * vector
        XCTAssertEqual(scaled, expected)
    }
    
    func testReflectionIsScaling() {
        let transform = Matrix.scale(-1, 1, 1)
        let point = Tuple.point(2, 3, 4)
        let expected = Tuple.point(-2, 3, 4)
        let reflected = transform * point
        XCTAssertEqual(reflected, expected)
    }
    
    func testRotatingPointAroundXAxis() {
        let point = Tuple.point(0, 1, 0)
        let halfQuarter = Matrix.rotationX(.pi / 4.0)
        let fullQuarter = Matrix.rotationX(.pi / 2)
        let halfRotatedExpected = Tuple.point(0, sqrt(2) / 2, sqrt(2) / 2)
        let fullRotatedExpected = Tuple.point(0, 0, 1)
        let halfRotated = halfQuarter * point
        let fullRotated = fullQuarter * point
        XCTAssertEqual(halfRotated, halfRotatedExpected)
        XCTAssertEqual(fullRotated, fullRotatedExpected)
    }
    
    func testInverseRotation() {
        let point = Tuple.point(0, 1, 0)
        let rotation = Matrix.rotationX(.pi / 4)
        guard let inverse = rotation.inverse else {
            XCTFail("Could not invert matrix.")
            return
        }
        let expected = Tuple.point(0, sqrt(2) / 2, -sqrt(2) / 2)
        let rotated = inverse * point
        XCTAssertEqual(rotated, expected)
    }
    
    func testRotatingPointAroundYAxis() {
        let point = Tuple.point(0, 0, 1)
        let halfQuarter = Matrix.rotationY(.pi / 4.0)
        let fullQuarter = Matrix.rotationY(.pi / 2)
        let halfRotatedExpected = Tuple.point( sqrt(2) / 2, 0, sqrt(2) / 2)
        let fullRotatedExpected = Tuple.point(1, 0, 0)
        let halfRotated = halfQuarter * point
        let fullRotated = fullQuarter * point
        XCTAssertEqual(halfRotated, halfRotatedExpected)
        XCTAssertEqual(fullRotated, fullRotatedExpected)
    }
    
    func testRotatingPointAroundZAxis() {
        let point = Tuple.point(0, 1, 0)
        let halfQuarter = Matrix.rotationZ(.pi / 4.0)
        let fullQuarter = Matrix.rotationZ(.pi / 2)
        let halfRotatedExpected = Tuple.point( -sqrt(2) / 2, sqrt(2) / 2, 0)
        let fullRotatedExpected = Tuple.point(-1, 0, 0)
        let halfRotated = halfQuarter * point
        let fullRotated = fullQuarter * point
        XCTAssertEqual(halfRotated, halfRotatedExpected)
        XCTAssertEqual(fullRotated, fullRotatedExpected)
    }

    func testShearMovesXInProportionToY() {
        let transform = Matrix.shear(1, 0, 0, 0, 0, 0)
        let point = Tuple.point(2, 3, 4)
        let expected = Tuple.point(5, 3, 4)
        let transformed = transform * point
        XCTAssertEqual(expected, transformed)
    }
    
    func testShearMovesXInProportionToZ() {
        let transform = Matrix.shear(0, 1, 0, 0, 0, 0)
        let point = Tuple.point(2, 3, 4)
        let expected = Tuple.point(6, 3, 4)
        let transformed = transform * point
        XCTAssertEqual(expected, transformed)
    }

    func testShearMovesYInProportionToX() {
        let transform = Matrix.shear(0, 0, 1, 0, 0, 0)
        let point = Tuple.point(2, 3, 4)
        let expected = Tuple.point(2, 5, 4)
        let transformed = transform * point
        XCTAssertEqual(expected, transformed)
    }

    func testShearMovesYInProportionToZ() {
        let transform = Matrix.shear(0, 0, 0, 1, 0, 0)
        let point = Tuple.point(2, 3, 4)
        let expected = Tuple.point(2, 7, 4)
        let transformed = transform * point
        XCTAssertEqual(expected, transformed)
    }

    func testShearMovesZInProportionToX() {
        let transform = Matrix.shear(0, 0, 0, 0, 1, 0)
        let point = Tuple.point(2, 3, 4)
        let expected = Tuple.point(2, 3, 6)
        let transformed = transform * point
        XCTAssertEqual(expected, transformed)
    }

    func testShearMovesZInProportionToY() {
        let transform = Matrix.shear(0, 0, 0, 0, 0, 1)
        let point = Tuple.point(2, 3, 4)
        let expected = Tuple.point(2, 3, 7)
        let transformed = transform * point
        XCTAssertEqual(expected, transformed)
    }
    
    func testIndividualTransformationsAppliedInSequence() {
        let point = Tuple.point(1, 0, 1)
        let matrixA = Matrix.rotationX(.pi / 2)
        let matrixB = Matrix.scale(5, 5, 5)
        let matrixC = Matrix.translation(10, 5, 7)
        // apply rotation first
        let point2 = matrixA * point
        let expectedPoint2 = Tuple.point(1, -1, 0)
        XCTAssertEqual(point2, expectedPoint2)
        // then apply scaling
        let point3 = matrixB * point2
        let expectedPoint3 = Tuple.point(5, -5, 0)
        XCTAssertEqual(point3, expectedPoint3)
        // then apply translation
        let point4 = matrixC * point3
        let expectedPoint4 = Tuple.point(15, 0, 7)
        XCTAssertEqual(point4, expectedPoint4)
    }

    func testChainedTransformationsMustBeAppliedIReverseOrder() {
        let point = Tuple.point(1, 0, 1)
        let matrixA = Matrix.rotationX(.pi / 2)
        let matrixB = Matrix.scale(5, 5, 5)
        let matrixC = Matrix.translation(10, 5, 7)
        let transformation = matrixC * matrixB * matrixA
        let transformed = transformation * point
        let expected = Tuple.point(15, 0, 7)
        XCTAssertEqual(transformed, expected)
    }
}
