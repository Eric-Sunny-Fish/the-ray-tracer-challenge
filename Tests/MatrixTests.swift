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
    
    func testDeterminant2x2Matrix() {
        let matrix = Matrix(rows: 2, columns: 2, values: [1, 5, -3, 2])
        XCTAssertEqual(matrix.determinant, 17)
    }
    
    func testSubmaxtrixOf3x3Is2x2() {
        let matrix = Matrix(rows: 3, columns: 3, values: [1, 5, 0, -3, 2, 7, 0, 6, -3])
        let expected = Matrix(rows: 2, columns: 2, values: [-3, 2, 0, 6])
        let submatrix = matrix.submatrixRemoving(row: 0, column: 2)
        XCTAssertEqual(submatrix, expected)
    }
    
    func testSubmatrixOf4x4Is3x3() {
        let matrix = Matrix(
            rows: 4,
            columns: 4,
            values: [-6, 1, 1, 6, -8, 5, 8, 6, -1, 0, 8, 2, -7, 1, -1, 1]
        )
        let submatrix = matrix.submatrixRemoving(row: 2, column: 1)
        let expected = Matrix(rows: 3, columns: 3, values: [-6, 1, 6, -8, 8, 6, -7, -1, 1])
        XCTAssertEqual(submatrix, expected)
    }
    
    func testCalculatingMinor3x3() {
        let matrix = Matrix(rows: 3, columns: 3, values: [3, 5, 0, 2, -1, -7, 6, -1, 5])
        let submatrix = matrix.submatrixRemoving(row: 1, column: 0)
        XCTAssertEqual(submatrix.determinant, 25)
        XCTAssertEqual(matrix.minor(row: 1, column: 0), 25)
    }
    
    func testCalculatingCofactor3x3() {
        let matrix = Matrix(rows: 3, columns: 3, values: [3, 5, 0, 2, -1, -7, 6, -1, 5])
        XCTAssertEqual(matrix.minor(row: 0, column: 0), -12)
        XCTAssertEqual(matrix.cofactor(row: 0, column: 0), -12)
        XCTAssertEqual(matrix.minor(row: 1, column: 0), 25)
        XCTAssertEqual(matrix.cofactor(row: 1, column: 0), -25)
    }
    
    func testCalculatingDeterminant3x3() {
        let matrix = Matrix(rows: 3, columns: 3, values: [1, 2, 6, -5, 8, -4, 2, 6, 4])
        XCTAssertEqual(matrix.cofactor(row: 0, column: 0), 56)
        XCTAssertEqual(matrix.cofactor(row: 0, column: 1), 12)
        XCTAssertEqual(matrix.cofactor(row: 0, column: 2), -46)
        XCTAssertEqual(matrix.determinant, -196)
    }
    
    func testCalculatingDeterminant4x4() {
        let matrix = Matrix(
            rows: 4,
            columns: 4,
            values: [-2, -8, 3, 5, -3, 1, 7, 3, 1, 2, -9, 6, -6, 7, 7, -9]
        )
        XCTAssertEqual(matrix.cofactor(row: 0, column: 0), 690)
        XCTAssertEqual(matrix.cofactor(row: 0, column: 1), 447)
        XCTAssertEqual(matrix.cofactor(row: 0, column: 2), 210)
        XCTAssertEqual(matrix.cofactor(row: 0, column: 3), 51)
        XCTAssertEqual(matrix.determinant, -4071)
    }
    
    func testInvertibility() {
        let matrix = Matrix(rows: 4, columns: 4, values: [6, 4, 4, 4, 5, 5, 7, 6, 4, -9, 3, -7, 9, 1, 7, -6])
        XCTAssertEqual(matrix.determinant, -2120)
        XCTAssertTrue(matrix.invertable)
    }
    
    func testNotInvertable() {
        let matrix = Matrix(
            rows: 4,
            columns: 4,
            values: [-4, 2, -2, -3, 9, 6, 2, 6, 0, -5, 1, -5, 0, 0, 0, 0]
        )
        XCTAssertEqual(matrix.determinant, 0)
        XCTAssertFalse(matrix.invertable)
    }
    
    func testCalculatingInverse() {
        let matrix = Matrix(
            rows: 4,
            columns: 4,
            values: [-5, 2, 6, -8, 1, -5, 1, 8, 7, 7, -6, -7, 1, -3, 7, 4]
        )
        guard let inverse = matrix.inverse else {
            XCTFail("Could not make inverse")
            return
        }
        let expected = Matrix(
            rows: 4,
            columns: 4,
            values: [
                0.21805, 0.45113, 0.24060, -0.04511,
                -0.80827, -1.45677, -0.44361, 0.52068,
                -0.07895, -0.22368, -0.05263, 0.19737,
                -0.52256, -0.81391, -0.30075, 0.30639
            ]
        )
        XCTAssertEqual(matrix.determinant, 532)
        XCTAssertEqual(matrix.cofactor(row: 2, column: 3), -160)
        XCTAssertEqual(inverse[2, 3], 105 / 532)
        XCTAssertEqual(inverse, expected)
    }
    
    func testCalculatingAnotherInverse() {
        let matrix = Matrix(
            rows: 4,
            columns: 4,
            values: [
                8, -5, 9, 2,
                7, 5, 6, 1,
                -6, 0, 9, 6,
                -3, 0, -9, -4
            ]
        )
        guard let inverse = matrix.inverse else {
            XCTFail("Could not generate inverse.")
            return
        }
        let expected = Matrix(
            rows: 4,
            columns: 4,
            values: [
                -0.15385, -0.15385, -0.28205, -0.53846,
                -0.07692, 0.12308, 0.02564, 0.03077,
                0.35897, 0.35897, 0.43590, 0.92308,
                -0.69231, -0.69231, -0.76923, -1.92308
            ]
        )
        XCTAssertEqual(inverse, expected)
    }
    func testCalculatingYetAnotherInverse() {
        let matrix = Matrix(
            rows: 4,
            columns: 4,
            values: [
                9, 3, 0, 9,
                -5, -2, -6, -3,
                -4, 9, 6, 4,
                -7, 6, 6, 2
            ]
        )
        guard let inverse = matrix.inverse else {
            XCTFail("Could not generate inverse")
            return
        }
        let expected = Matrix(
            rows: 4,
            columns: 4,
            values: [
                -0.04074, -0.07778, 0.14444, -0.22222,
                -0.07778, 0.03333, 0.36667, -0.33333,
                -0.02901, -0.14630, -0.10926, 0.12963,
                0.17778, 0.06667, -0.26667, 0.33333
            ]
        )
        XCTAssertEqual(inverse, expected)
    }
    
    func testMultiplyingProductByInverse() {
        let matrixA = Matrix(
            rows: 4,
            columns: 4,
            values: [3, -9, 7, 3, 3, -8, 2, -9, -4, 4, 4, 1, -6, 5, -1, 1]
        )
        let matrixB = Matrix(
            rows: 4,
            columns: 4,
            values: [8, 2, 2, 2, 3, -1, 7, 0, 7, 0, 5, 4, 6, -2, 0, 5]
        )
        let matrixC = matrixA * matrixB
        guard let inverseB = matrixB.inverse else {
            XCTFail("Could not generate inverse")
            return
        }
        let reverted = matrixC * inverseB
        XCTAssertEqual(reverted, matrixA)
    }
    
    func testDefaltViewTransform() {
        let from = Tuple.point(0, 0, 0)
        // swiftlint:disable:next identifier_name
        let to = Tuple.point(0, 0, -1)
        // swiftlint:disable:next identifier_name
        let up = Tuple.vector(0, 1, 0)
        let transform = Matrix.viewTransform(from: from, to: to, up: up)
        XCTAssertEqual(transform, Matrix.identity)
    }
    
    func testViewTransformLookingBack() {
        let from = Tuple.point(0, 0, 0)
        // swiftlint:disable:next identifier_name
        let to = Tuple.point(0, 0, 1)
        // swiftlint:disable:next identifier_name
        let up = Tuple.vector(0, 1, 0)
        let transform = Matrix.viewTransform(from: from, to: to, up: up)
        let expected = Matrix.scale(-1, 1, -1)
        XCTAssertEqual(transform, expected)
    }
    
    func testViewTransformMovesWorld() {
        let from = Tuple.point(0, 0, 8)
        // swiftlint:disable:next identifier_name
        let to = Tuple.point(0, 0, 0)
        // swiftlint:disable:next identifier_name
        let up = Tuple.vector(0, 1, 0)
        let transform = Matrix.viewTransform(from: from, to: to, up: up)
        let expected = Matrix.translation(0, 0, -8)
        XCTAssertEqual(transform, expected)
    }
    
    func testArbitraryViewTransform() {
        let from = Tuple.point(1, 3, 2)
        // swiftlint:disable:next identifier_name
        let to = Tuple.point(4, -2, 8)
        // swiftlint:disable:next identifier_name
        let up = Tuple.vector(1, 1, 0)
        let transform = Matrix.viewTransform(from: from, to: to, up: up)
        let expected = Matrix(
            rows: 4,
            columns: 4,
            values: [
                -0.50709,
                0.50709,
                0.67612,
                -2.36643,
                0.76772,
                0.60609,
                0.12122,
                -2.82843,
                -0.35857,
                0.59761,
                -0.71714,
                0.00000,
                0.00000,
                0.00000,
                0.00000,
                1.00000
            ]
        )
        XCTAssertEqual(transform, expected)
    }
}
