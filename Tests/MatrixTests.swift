//
//  MatrixTests.swift
//
//
//  Created by Eric Berna on 9/27/23.
//

import XCTest
@testable import TheRayTracerChallenge

final class MatrixTests: XCTestCase {
    func testConstructingAndInspectingMatrix() {
        let matrix = Matrix(
            rows: 4,
            columns: 4,
            values: [1, 2, 3, 4, 5.5, 6.5, 7.5, 8.5, 9, 10, 11, 12, 13.5, 14.5, 15.5, 16.5]
        )
        XCTAssertEqual(matrix[0, 0], 1)
        XCTAssertEqual(matrix[0, 3], 4)
        XCTAssertEqual(matrix[1, 0], 5.5)
        XCTAssertEqual(matrix[1, 2], 7.5)
        XCTAssertEqual(matrix[2, 2], 11)
        XCTAssertEqual(matrix[3, 0], 13.5)
        XCTAssertEqual(matrix[3, 2], 15.5)
    }
    
    func test2x2Matrix() {
        let matrix = Matrix(rows: 2, columns: 2, values: [ -3, 5, 1, -2])
        XCTAssertEqual(matrix[0, 0], -3)
        XCTAssertEqual(matrix[0, 1], 5)
        XCTAssertEqual(matrix[1, 0], 1)
        XCTAssertEqual(matrix[1, 1], -2)
    }
    
    func test3x3Matrix() {
        let matrix = Matrix(rows: 3, columns: 3, values: [-3, 5, 0, 1, -2, -7, 0, 1, 1])
        XCTAssertEqual(matrix[0, 0], -3)
        XCTAssertEqual(matrix[1, 1], -2)
        XCTAssertEqual(matrix[2, 2], 1)
    }
    
    func testMatrixIsEqual() {
        let matrixA = Matrix(
            rows: 4,
            columns: 4,
            values: [1, (9.777 - 5.777) / 2, 3, 4, 5, 6, 7, 8, 9, 8, 7, 6, 5, 4, 3, 2]
        )
        let matrixB = Matrix(rows: 4, columns: 4, values: [1, 2, 3, 4, 5, 6, 7, 8, 9, 8, 7, 6, 5, 4, 3, 2])
        XCTAssertEqual(matrixA, matrixB)
    }
    
    func testMatrxIsNotEqual() {
        let matrixA = Matrix(rows: 4, columns: 4, values: [1, 2, 3, 4, 5, 6, 7, 8, 9, 8, 7, 6, 5, 4, 3, 2])
        let matrixB = Matrix(rows: 4, columns: 4, values: [1, 2, 3, 4, 5, 6, 7, 8, 1, 8, 7, 6, 5, 4, 3, 2])
        XCTAssertNotEqual(matrixA, matrixB)
    }
    
    func testMatrixMultiplication() {
        let matrixA = Matrix(rows: 4, columns: 4, values: [1, 2, 3, 4, 5, 6, 7, 8, 9, 8, 7, 6, 5, 4, 3, 2])
        let matrixB = Matrix(rows: 4, columns: 4, values: [-2, 1, 2, 3, 3, 2, 1, -1, 4, 3, 6, 5, 1, 2, 7, 8])
        let expected = Matrix(
            rows: 4,
            columns: 4,
            values: [20, 22, 50, 48, 44, 54, 114, 108, 40, 58, 110, 102, 16, 26, 46, 42]
        )
        XCTAssertEqual(matrixA * matrixB, expected)
    }
    
    func testMatrixTupleMultiplication() {
        let matrix = Matrix(rows: 4, columns: 4, values: [1, 2, 3, 4, 2, 4, 4, 2, 8, 6, 4, 1, 0, 0, 0, 1])
        let tuple = Tuple(1, 2, 3, 1)
        let expected = Tuple(18, 24, 33, 1)
        XCTAssertEqual(matrix * tuple, expected)
    }
    
    func testMatrixIdentityMultiplication() {
        let matrix = Matrix(rows: 4, columns: 4, values: [0, 1, 2, 4, 1, 2, 4, 8, 2, 4, 8, 16, 4, 8, 16, 32])
        let identiyMatrix = Matrix.identity
        XCTAssertEqual(matrix * identiyMatrix, matrix)
    }
    
    func testTupleIdentityMultiplication() {
        let tuple = Tuple(1, 2, 3, 4)
        let matrix = Matrix.identity
        XCTAssertEqual(matrix * tuple, tuple)
    }
    
    func testMatrixTranspose() {
        let example = Matrix(rows: 4, columns: 4, values: [0, 9, 3, 0, 9, 8, 0, 8, 1, 8, 5, 3, 0, 0, 5, 8])
        let expected = Matrix(rows: 4, columns: 4, values: [0, 9, 1, 0, 9, 8, 8, 0, 3, 0, 5, 5, 0, 8, 3, 8])
        XCTAssertEqual(example.transpose, expected)
    }
    
    func testIdentityMatrixTranspose() {
        XCTAssertEqual(Matrix.identity.transpose, Matrix.identity)
    }
}
