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
    public var unit: Self {
        let mag = magnitude
        return Self(x / mag, y / mag, z / mag, w / mag)
    }
    
    public init(_ x: Double, _ y: Double, _ z: Double, _ w: Double) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
    
    public static func point(_ x: Double, _ y: Double, _ z: Double) -> Self {
        Self(x, y, z, 1.0)
    }
    
    public static func vector(_ x: Double, _ y: Double, _ z: Double) -> Self {
        Self(x, y, z, 0.0)
    }
    
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z, lhs.w + rhs.w)
    }
    
    static func - (lhs: Self, rhs: Self) -> Self {
        Self(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z, lhs.w - rhs.w)
    }
    
    static var zeroVector: Self {
        Self.vector(0, 0, 0)
    }
    
    static prefix func - (tuple: Self) -> Self {
        Self(-tuple.x, -tuple.y, -tuple.z, -tuple.w)
    }
    
    public static func * (lhs: Double, rhs: Self) -> Self {
        Self(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z, lhs * rhs.w)
    }
    
    public static func * (lhs: Self, rhs: Double) -> Self {
        Self(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, lhs.w * rhs)
    }
    
    public static func * (lhs: Self, rhs: Self) -> Self {
        Self.vector(
            lhs.y * rhs.z - lhs.z * rhs.y,
            lhs.z * rhs.x - lhs.x * rhs.z,
            lhs.x * rhs.y - lhs.y * rhs.x
        )
    }
    
    public static func / (lhs: Self, rhs: Double) -> Self {
        Self(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs, lhs.w / rhs)
    }
    
    // How can one not use the dot charater for dot product?
    // swiftlint:disable:next identifier_name
    public static func • (lhs: Self, rhs: Self) -> Double {
        lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * rhs.z + lhs.w * rhs.w
    }
}
