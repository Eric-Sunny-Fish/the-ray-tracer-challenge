//
//  Tuple.swift
//  The Ray Tracer Challenge
//
//  Created by Eric Berna on 9/20/23.
//

import Foundation

infix operator • : MultiplicationPrecedence
public struct Tuple: Equatable {
    public let x: Double
    public let y: Double
    public let z: Double
    public let w: Double
    var isPoint: Bool {
            w == 1.0
    }
    var isVector: Bool {
            w == 0.0
    }
    var magnitude: Double {
            sqrt(x * x + y * y + z * z + w * w)
    }
    public var unit: Tuple {
            let m = magnitude
            return Tuple(x / m, y / m, z / m, w / m)
    }
    
    public init(_ x: Double, _ y: Double, _ z: Double, _ w: Double) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
    
    public static func point(_ x: Double, _ y: Double, _ z: Double) -> Tuple {
        Tuple(x, y, z, 1.0)
    }
    
    public static func vector(_ x: Double, _ y: Double, _ z: Double) -> Tuple {
        Tuple(x, y, z, 0.0)
    }
    
    public static func + (lhs: Tuple, rhs: Tuple) -> Tuple {
        Tuple(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z, lhs.w + rhs.w)
    }
    
    static func - (lhs: Tuple, rhs: Tuple) -> Tuple {
        Tuple(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z, lhs.w - rhs.w)
    }
    
    static var zeroVector: Tuple {
            Tuple.vector(0, 0, 0)
    }
    
    static prefix func - (tuple: Tuple) -> Tuple {
        return Tuple(-tuple.x, -tuple.y, -tuple.z, -tuple.w)
    }

    public static func * (lhs: Double, rhs: Tuple) -> Tuple {
        Tuple(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z, lhs * rhs.w)
    }

    public static func * (lhs: Tuple, rhs: Double) -> Tuple {
        Tuple(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, lhs.w * rhs)
    }
    
    public static func * (lhs: Tuple, rhs: Tuple) -> Tuple {
        Tuple.vector(
            lhs.y * rhs.z - lhs.z * rhs.y,
            lhs.z * rhs.x - lhs.x * rhs.z,
            lhs.x * rhs.y - lhs.y * rhs.x
        )
    }

    public static func / (lhs: Tuple, rhs: Double) -> Tuple {
        Tuple(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs, lhs.w / rhs)
    }

    public static func • (lhs: Tuple, rhs: Tuple) -> Double {
        lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * rhs.z + lhs.w * rhs.w
    }
}
