//
//  TupleTests.swift
//  The Ray Tracer ChallengeTests
//
//  Created by Eric Berna on 9/20/23.
//

import XCTest
@testable import TheRayTracerChallenge

final class TupleTests: XCTestCase {
    func testTuplePoint() throws {
        // Scenario: A tuple with w = 1.0 is a point
        // Given a <- tuple(4.3, -4.2, 3.1, 1.0)
        let tuple = Tuple(4.3, -4.2, 3.1, 1.0)
        // Then a.x = 4.3
        XCTAssertEqual(tuple.x, 4.3)
        // And a.y = -4.2
        XCTAssertEqual(tuple.y, -4.2)
        // And a.z = 3.1
        XCTAssertEqual(tuple.z, 3.1)
        // And a.w = 1.0
        XCTAssertEqual(tuple.w, 1.0)
        // And a is a point
        XCTAssertTrue(tuple.isPoint)
        // And a is not a vector
        XCTAssertFalse(tuple.isVector)
    }

    func testTupleVector() throws {
        // Scenario: A tuple with w = 0.0 is a vector
        // Given a <- tuple(4.3, -4.2, 3.1, 0.0)
        let tuple = Tuple(4.3, -4.2, 3.1, 0.0)
        // Then a.x = 4.3
        XCTAssertEqual(tuple.x, 4.3)
        // And a.y = -4.2
        XCTAssertEqual(tuple.y, -4.2)
        // And a.z = 3.1
        XCTAssertEqual(tuple.z, 3.1)
        // And a.w = 1.0
        XCTAssertEqual(tuple.w, 0.0, accuracy: 0.001)
        // And a is a point
        XCTAssertFalse(tuple.isPoint)
        // And a is not a vector
        XCTAssertTrue(tuple.isVector)
    }

    func testTuplePointFunction() {
        // Scenario: point() creates tuples with w = 1
        // Given p <- Tuple.point(4, -4, 3)
        let point = Tuple.point(4, -4, 3)
        // Then p == Tuple(4, -4, 3, 1)
        let expected = Tuple(4, -4, 3, 1)
        XCTAssertEqual(point, expected)
    }
    
    func testTupleVectorFunction() {
        // Scenario: vector() creates tuples with w = 0
        // Given v <- Tuple.vector(4, -4, 3)
        let vector = Tuple.vector(4, -4, 3)
        // Then v == Tuple(4, -4, 3, 0)
        let expected = Tuple(4, -4, 3, 0)
        XCTAssertEqual(vector, expected)
    }
    
    func testTupleEqualityPrecision() {
        let precisonFactor = Double(1e10)
        let pointA = Tuple.point(4 / precisonFactor, 5 / precisonFactor, 6 / precisonFactor)
        let pointB = Tuple.point(
            2 / precisonFactor + 2 / precisonFactor,
            2 / precisonFactor + 3 / precisonFactor,
            2 / precisonFactor + 4 / precisonFactor
        )
        XCTAssertEqual(pointA, pointB)
    }
    
    func testAddingTwoTuples() {
        // Scenario: Adding two tuples
        // Given
        let tuple1 = Tuple(3, -2, 5, 1)
        let tuple2 = Tuple(-2, 3, 1, 0)
        let expected = Tuple(1, 1, 6, 1)
        // Then
        XCTAssertEqual(tuple1 + tuple2, expected)
    }
    
    func testSubtractingTwoPoints() {
        let point1 = Tuple.point(3, 2, 1)
        let point2 = Tuple.point(5, 6, 7)
        let expected = Tuple.vector(-2, -4, -6)
        XCTAssertEqual(point1 - point2, expected)
    }
    
    func testSubtractingVectorFromPoint() {
        let point = Tuple.point(3, 2, 1)
        let vector = Tuple.vector(5, 6, 7)
        let expected = Tuple.point(-2, -4, -6)
        XCTAssertEqual(point - vector, expected)
    }
    
    func testSubtractingTwoVectors() {
        let vector1 = Tuple.vector(3, 2, 1)
        let vector2 = Tuple.vector(5, 6, 7)
        let expected = Tuple.vector(-2, -4, -6)
        XCTAssertEqual(vector1 - vector2, expected)
    }
    
    func testSubtractingVectorFromTheZeroVector() {
        let zero = Tuple.zeroVector
        let vector = Tuple.vector(1, -2, 3)
        let expected = Tuple.vector(-1, 2, -3)
        XCTAssertEqual(zero - vector, expected)
    }
    
    func testNegatingTuple() {
        let tuple = Tuple(1, -2, 3, -4)
        let expected = Tuple(-1, 2, -3, 4)
        XCTAssertEqual(-tuple, expected)
    }
    
    func testMultiplyingTupleByScalar() {
        let tuple = Tuple(1, -2, 3, -4)
        var expected = Tuple(3.5, -7, 10.5, -14)
        XCTAssertEqual(tuple * 3.5, expected)
        XCTAssertEqual(3.5 * tuple, expected)
        expected = Tuple(0.5, -1, 1.5, -2)
        XCTAssertEqual(tuple * 0.5, expected)
        XCTAssertEqual(0.5 * tuple, expected)
    }
    
    func testDividingTupleByScalar() {
        let tuple = Tuple(1, -2, 3, -4)
        let expected = Tuple(0.5, -1, 1.5, -2)
        XCTAssertEqual(tuple / 2, expected)
    }

    func testVectorMagnitude() {
        let vector1 = Tuple.vector(1, 0, 0)
        XCTAssertEqual(vector1.magnitude, 1)
        let vector2 = Tuple.vector(0, 1, 0)
        XCTAssertEqual(vector2.magnitude, 1)
        let vector3 = Tuple.vector(0, 0, 1)
        XCTAssertEqual(vector3.magnitude, 1)
        let vector4 = Tuple.vector(1, 2, 3)
        XCTAssertEqual(vector4.magnitude, sqrt(14))
        let vector5 = Tuple.vector(-1, -2, -3)
        XCTAssertEqual(vector5.magnitude, sqrt(14))
    }
    
    func testNormalizingVector() {
        let vector1 = Tuple.vector(4, 0, 0)
        var expected = Tuple.vector(1, 0, 0)
        XCTAssertEqual(vector1.unit, expected)
        let vector2 = Tuple.vector(1, 2, 3)
        let mag = vector2.magnitude
        expected = Tuple.vector(1 / mag, 2 / mag, 3 / mag)
        XCTAssertEqual(vector2.unit, expected)
        XCTAssertEqual(vector2.unit.magnitude, 1)
    }
    
    func testDotProductOfTwoTuples() {
        let tupleA = Tuple.vector(1, 2, 3)
        let tupleB = Tuple.vector(2, 3, 4)
        let dot = tupleA • tupleB
        let expected = 20
        XCTAssertEqual(dot, 20, "dot: \(dot) does not equal expected: \(expected)")
    }
    
    func testCrossProductOfTwoVectors() {
        let vectorA = Tuple.vector(1, 2, 3)
        let vectorB = Tuple.vector(2, 3, 4)
        let expectedab = Tuple.vector(-1, 2, -1)
        let expectedba = Tuple.vector(1, -2, 1)
        XCTAssertEqual(vectorA * vectorB, expectedab)
        XCTAssertEqual(vectorB * vectorA, expectedba)
    }
    
    func testProjectile() {
        struct Projectile {
            var position: Tuple
            var velocity: Tuple
        }
        struct Environment {
            var gravity: Tuple
            var wind: Tuple
        }
        func tick(environment: Environment, projectile: Projectile) -> Projectile {
            let position = projectile.position + projectile.velocity
            let velocity = projectile.velocity + environment.gravity + environment.wind
            return Projectile(position: position, velocity: velocity)
        }
        var projectile = Projectile(position: Tuple.point(0, 1, 0), velocity: Tuple.vector(1, 1, 0))
        let environment = Environment(gravity: Tuple.vector(0, -0.1, 0), wind: Tuple.vector(-0.01, 0, 0))
        var ticks: Int = 0
        while projectile.position.y > 0 {
            projectile = tick(environment: environment, projectile: projectile)
            ticks += 1
            print("Height: \(projectile.position.y)")
        }
        print("Ticks: \(ticks)")
    }
}
