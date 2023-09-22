//
//  Tuple.swift
//  The Ray Tracer Challenge
//
//  Created by Eric Berna on 9/20/23.
//

import Foundation

infix operator • : MultiplicationPrecedence
struct Tuple: Equatable {
    let x: Double
    let y: Double
    let z: Double
    let w: Double
    var isPoint: Bool {
        get {
            w == 1.0
        }
    }
    var isVector: Bool {
        get {
            w == 0.0
        }
    }
    var magnitude: Double {
        get {
            sqrt(x * x + y * y + z * z + w * w)
        }
    }
    var unit: Tuple {
        get {
            let m = magnitude
            return Tuple(x / m, y / m, z / m, w / m)
        }
    }
    
    init(_ x: Double, _ y: Double, _ z: Double, _ w: Double) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
    
    static func point(_ x: Double, _ y: Double, _ z: Double) -> Tuple {
        Tuple(x, y, z, 1.0)
    }
    
    static func vector(_ x: Double, _ y: Double, _ z: Double) -> Tuple {
        Tuple(x, y, z, 0.0)
    }
    
    static func + (lhs: Tuple, rhs: Tuple) -> Tuple {
        Tuple(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z, lhs.w + rhs.w)
    }
    
    static func - (lhs: Tuple, rhs: Tuple) -> Tuple {
        Tuple(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z, lhs.w - rhs.w)
    }
    
    static var zeroVector: Tuple {
        get {
            Tuple.vector(0, 0, 0)
        }
    }
    
    static prefix func -(tuple: Tuple) -> Tuple {
        return Tuple(-tuple.x, -tuple.y, -tuple.z, -tuple.w)
    }

    static func * (lhs: Double, rhs: Tuple) -> Tuple {
        Tuple(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z, lhs * rhs.w)
    }

    static func * (lhs: Tuple, rhs: Double) -> Tuple {
        Tuple(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, lhs.w * rhs)
    }
    
    static func * (lhs: Tuple, rhs: Tuple) -> Tuple {
        Tuple.vector(
            lhs.y * rhs.z - lhs.z * rhs.y,
            lhs.z * rhs.x - lhs.x * rhs.z,
            lhs.x * rhs.y - lhs.y * rhs.x
        )
    }


    static func / (lhs: Tuple, rhs: Double) -> Tuple {
        Tuple(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs, lhs.w / rhs)
    }

    static func • (lhs: Tuple, rhs: Tuple) -> Double {
        lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * rhs.z + lhs.w * rhs.w
    }
}
