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
        let a = Tuple(4.3, -4.2, 3.1, 1.0)
        // Then a.x = 4.3
        XCTAssert(a.x == 4.3)
        // And a.y = -4.2
        XCTAssert(a.y == -4.2)
        // And a.z = 3.1
        XCTAssert(a.z == 3.1)
        // And a.w = 1.0
        XCTAssert(a.w == 1.0)
        // And a is a point
        XCTAssert(a.isPoint)
        // And a is not a vector
        XCTAssertFalse(a.isVector)
    }

    func testTupleVector() throws {
        // Scenario: A tuple with w = 0.0 is a vector
        // Given a <- tuple(4.3, -4.2, 3.1, 0.0)
        let a = Tuple(4.3, -4.2, 3.1, 0.0)
        // Then a.x = 4.3
        XCTAssert(a.x == 4.3)
        // And a.y = -4.2
        XCTAssert(a.y == -4.2)
        // And a.z = 3.1
        XCTAssert(a.z == 3.1)
        // And a.w = 1.0
        XCTAssertEqual(a.w, 0.0, accuracy: 0.001)
        // And a is a point
        XCTAssertFalse(a.isPoint)
        // And a is not a vector
        XCTAssert(a.isVector)
    }

    func testTuplePointFunction() {
        // Scenario: point() creates tuples with w = 1
        // Given p <- Tuple.point(4, -4, 3)
        let p = Tuple.point(4, -4, 3)
        // Then p == Tuple(4, -4, 3, 1)
        let expected = Tuple(4, -4, 3, 1)
        XCTAssert(p == expected)
    }
    
    func testTupleVectorFunction() {
        // Scenario: vector() creates tuples with w = 0
        // Given v <- Tuple.vector(4, -4, 3)
        let v = Tuple.vector(4, -4, 3)
        // Then v == Tuple(4, -4, 3, 0)
        let expected = Tuple(4, -4, 3, 0)
        XCTAssert(v == expected)
    }
    
    func testTupleEqualityPrecision() {
        let precisonFactor = Double(1e10)
        let a = Tuple.point(4/precisonFactor, 5/precisonFactor, 6/precisonFactor)
        let b = Tuple.point(
            2/precisonFactor + 2/precisonFactor,
            2/precisonFactor + 3/precisonFactor,
            2/precisonFactor + 4/precisonFactor)
        XCTAssert(a == b)
    }
    
    func testAddingTwoTuples() {
        // Scenario: Adding two tuples
        // Given
        let a1 = Tuple(3, -2, 5, 1)
        let a2 = Tuple(-2, 3, 1, 0)
        let expected = Tuple(1, 1, 6, 1)
        // Then
        XCTAssert(a1 + a2 == expected)
    }
    
    func testSubtractingTwoPoints() {
        let p1 = Tuple.point(3, 2, 1)
        let p2 = Tuple.point(5, 6, 7)
        let expected = Tuple.vector(-2, -4, -6)
        XCTAssert(p1 - p2 == expected)
    }
    
    func testSubtractingVectorFromPoint() {
        let p = Tuple.point(3, 2, 1)
        let v = Tuple.vector(5, 6, 7)
        let expected = Tuple.point(-2, -4, -6)
        XCTAssert(p - v == expected)
    }
    
    func testSubtractingTwoVectors() {
        let v1 = Tuple.vector(3, 2, 1)
        let v2 = Tuple.vector(5, 6, 7)
        let expected = Tuple.vector(-2, -4, -6)
        XCTAssert(v1 - v2 == expected)
    }
    
    func testSubtractingVectorFromTheZeroVector() {
        let zero = Tuple.zeroVector
        let v = Tuple.vector(1, -2, 3)
        let expected = Tuple.vector(-1, 2, -3)
        XCTAssert(zero - v == expected)
    }
    
    func testNegatingTuple() {
        let a = Tuple(1, -2, 3, -4)
        let expected = Tuple(-1, 2, -3, 4)
        XCTAssert(-a == expected)
    }
    
    func testMultiplyingTupleByScalar() {
        let a = Tuple(1, -2, 3, -4)
        var expected = Tuple(3.5, -7, 10.5, -14)
        XCTAssert(a * 3.5 == expected)
        XCTAssert(3.5 * a == expected)
        expected = Tuple(0.5, -1, 1.5, -2)
        XCTAssert(a * 0.5 == expected)
        XCTAssert(0.5 * a == expected)
    }
    
    func testDividingTupleByScalar() {
        let a = Tuple(1, -2, 3, -4)
        let expected = Tuple(0.5, -1, 1.5, -2)
        XCTAssert(a / 2 == expected)
    }

    func testVectorMagnitude() {
        let v1 = Tuple.vector(1, 0, 0)
        XCTAssert(v1.magnitude == 1)
        let v2 = Tuple.vector(0, 1, 0)
        XCTAssert(v2.magnitude == 1)
        let v3 = Tuple.vector(0, 0, 1)
        XCTAssert(v3.magnitude == 1)
        let v4 = Tuple.vector(1, 2, 3)
        XCTAssert(v4.magnitude == sqrt(14))
        let v5 = Tuple.vector(-1, -2, -3)
        XCTAssert(v5.magnitude == sqrt(14))
    }
    
    func testNormalizingVector() {
        let v1 = Tuple.vector(4, 0, 0)
        var expected = Tuple.vector(1, 0, 0)
        XCTAssert(v1.unit == expected)
        let v2 = Tuple.vector(1, 2, 3)
        let mag = v2.magnitude
        expected = Tuple.vector(1 / mag, 2 / mag, 3 / mag)
        XCTAssert(v2.unit == expected)
        XCTAssert(v2.unit.magnitude == 1)
    }
    
    func testDotProductOfTwoTuples() {
        let a = Tuple.vector(1, 2, 3)
        let b = Tuple.vector(2, 3, 4)
        let dot = a • b
        let expected = 20
        XCTAssert(dot == 20, "dot: \(dot) does not equal expected: \(expected)")
    }
    
    func testCrossProductOfTwoVectors() {
        let a = Tuple.vector(1, 2, 3)
        let b = Tuple.vector(2, 3, 4)
        let expectedab = Tuple.vector(-1, 2, -1)
        let expectedba = Tuple.vector(1, -2, 1)
        XCTAssert(a * b == expectedab)
        XCTAssert(b * a == expectedba)
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
        var p = Projectile(position: Tuple.point(0, 1, 0), velocity: Tuple.vector(1, 1, 0))
        let e = Environment(gravity: Tuple.vector(0, -0.1, 0), wind: Tuple.vector(-0.01, 0, 0))
        var ticks: Int = 0
        while p.position.y > 0 {
            p = tick(environment: e, projectile: p)
            ticks += 1
            print("Height: \(p.position.y)")
        }
        print("Ticks: \(ticks)")
    }

}
