//
//  Transformations.swift
//  
//
//  Created by Eric Berna on 10/8/23.
//

import Foundation

extension Matrix {
    public static func translation(_ x: Double, _ y: Double, _ z: Double) -> Matrix {
        var result = Self.identity
        result[0, 3] = x
        result[1, 3] = y
        result[2, 3] = z
        return result
    }
    
    public static func scale(_ x: Double, _ y: Double, _ z: Double) -> Matrix {
        var result = Self.identity
        result[0, 0] = x
        result[1, 1] = y
        result[2, 2] = z
        return result
    }
    
    public static func rotationX(_ radians: Double) -> Matrix {
        var result = Self.identity
        result[1, 1] = cos(radians)
        result[1, 2] = -sin(radians)
        result[2, 1] = sin(radians)
        result[2, 2] = cos(radians)
        return result
    }
    
    public static func rotationY(_ radians: Double) -> Matrix {
        var result = Self.identity
        result[0, 0] = cos(radians)
        result[0, 2] = sin(radians)
        result[2, 0] = -sin(radians)
        result[2, 2] = cos(radians)
        return result
    }
    
    public static func rotationZ(_ radians: Double) -> Matrix {
        var result = Self.identity
        result[0, 0] = cos(radians)
        result[0, 1] = -sin(radians)
        result[1, 0] = sin(radians)
        result[1, 1] = cos(radians)
        return result
    }
    
    // swiftlint:disable identifier_name function_parameter_count
    public static func shear(
        _ xY: Double,
        _ xZ: Double,
        _ yX: Double,
        _ yZ: Double,
        _ zX: Double,
        _ zY: Double
    ) -> Matrix {
        var result = Self.identity
        result[0, 1] = xY
        result[0, 2] = xZ
        result[1, 0] = yX
        result[1, 2] = yZ
        result[2, 0] = zX
        result[2, 1] = zY
        return result
    }
}
// swiftlint:enable identifier_name function_parameter_count
