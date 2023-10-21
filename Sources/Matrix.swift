//
//  Matrix.swift
//
//
//  Created by Eric Berna on 9/28/23.
//

import Foundation

public struct Matrix {
    public let rows: Int
    public let columns: Int
    public var transpose: Self {
        Self(
            rows: 4,
            columns: 4,
            values: [
                self[0, 0], self[1, 0], self[2, 0], self[3, 0],
                self[0, 1], self[1, 1], self[2, 1], self[3, 1],
                self[0, 2], self[1, 2], self[2, 2], self[3, 2],
                self[0, 3], self[1, 3], self[2, 3], self[3, 3]
            ]
        )
    }
    public var determinant: Double {
        var result = 0.0
        if self.rows == 2 {
            result = self[0, 0] * self[1, 1] - self[1, 0] * self[0, 1]
        } else {
            for cIndex in 0..<columns {
                result += self[0, cIndex] * cofactor(row: 0, column: cIndex)
            }
        }
        return result
    }
    public var invertable: Bool {
        self.determinant != 0.0
    }
    public var inverse: Self? {
        let deter = self.determinant
        guard deter != 0.0 else {
            return nil
        }
        var result = self
        for row in 0..<self.rows {
            for column in 0..<self.columns {
                result[column, row] = self.cofactor(row: row, column: column) / deter
            }
        }
        return result
    }
    private var values: [Double]
    
    public init(rows: Int, columns: Int, values: [Double]? = nil) {
        self.rows = rows
        self.columns = columns
        if let values {
            self.values = values
        } else {
            self.values = [Double](repeating: 0, count: rows * columns)
        }
    }
    
    public subscript(row: Int, column: Int) -> Double {
        get {
            values[row * rows + column]
        }
        set(newValue) {
            values[row * rows + column] = newValue
        }
    }
    
    public static func * (lhs: Self, rhs: Self) -> Self {
        var result = Self(rows: lhs.rows, columns: lhs.columns)
        for row in 0...3 {
            for col in 0...3 {
                result[row, col] =
                lhs[row, 0] * rhs[0, col] +
                lhs[row, 1] * rhs[1, col] +
                lhs[row, 2] * rhs[2, col] +
                lhs[row, 3] * rhs[3, col]
            }
        }
        return result
    }
    
    public static func * (lhs: Self, rhs: Tuple) -> Tuple {
        let x = lhs[0, 0] * rhs.x + lhs[0, 1] * rhs.y + lhs[0, 2] * rhs.z + lhs[0, 3] * rhs.w
        let y = lhs[1, 0] * rhs.x + lhs[1, 1] * rhs.y + lhs[1, 2] * rhs.z + lhs[1, 3] * rhs.w
        let z = lhs[2, 0] * rhs.x + lhs[2, 1] * rhs.y + lhs[2, 2] * rhs.z + lhs[2, 3] * rhs.w
        let w = lhs[3, 0] * rhs.x + lhs[3, 1] * rhs.y + lhs[3, 2] * rhs.z + lhs[3, 3] * rhs.w
        return Tuple(x, y, z, w)
    }
    
    public static let identity = Self(
        rows: 4,
        columns: 4,
        values: [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1]
    )
    
    public func submatrixRemoving(row: Int, column: Int) -> Self {
        var newValues = [Double]()
        newValues.reserveCapacity((rows - 1) * (columns - 1))
        for rIndex in 0..<rows {
            for cIndex in 0..<columns {
                if (rIndex != row) && (cIndex != column) {
                    newValues.append(self[rIndex, cIndex])
                }
            }
        }
        return Self(rows: rows - 1, columns: columns - 1, values: newValues)
    }
    
    public func minor(row: Int, column: Int) -> Double {
        self.submatrixRemoving(row: row, column: column).determinant
    }
    
    public func cofactor(row: Int, column: Int) -> Double {
        let sign = (row + column).isMultiple(of: 2) ? 1.0 : -1.0
        return sign * self.minor(row: row, column: column)
    }
}

extension Matrix: Equatable {
    public static func == (lhs: Matrix, rhs: Matrix) -> Bool {
        let epsilon = 5e-6
        guard lhs.rows == rhs.rows && lhs.columns == rhs.columns else {
            return false
        }
        for (lValue, rValue) in zip(lhs.values, rhs.values) where abs(lValue - rValue) > epsilon {
            return false
        }
        return true
    }
}
