//
//  Color.swift
//  The Ray Tracer Challenge
//
//  Created by Eric Berna on 9/21/23.
//

import Foundation

public struct Color {
    let red: Double
    let green: Double
    let blue: Double
    
    public init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    public static var black: Self {
        Self(red: 0, green: 0, blue: 0)
    }
    
    static func + (lhs: Self, rhs: Self) -> Self {
        Self(red: lhs.red + rhs.red, green: lhs.green + rhs.green, blue: lhs.blue + rhs.blue)
    }
    
    public static func - (lhs: Self, rhs: Self) -> Self {
        Self(red: lhs.red - rhs.red, green: lhs.green - rhs.green, blue: lhs.blue - rhs.blue)
    }
    
    public static func * (lhs: Self, rhs: Double) -> Self {
        Self(red: lhs.red * rhs, green: lhs.green * rhs, blue: lhs.blue * rhs)
    }
    
    public static func * (lhs: Self, rhs: Self) -> Self {
        Self(red: lhs.red * rhs.red, green: lhs.green * rhs.green, blue: lhs.blue * rhs.blue)
    }
}

extension Color: Equatable {
    public static func == (lhs: Color, rhs: Color) -> Bool {
        let rEqual = abs(lhs.red - rhs.red) < kEpsilon
        let gEqual = abs(lhs.green - rhs.green) < kEpsilon
        let bEqual = abs(lhs.blue - rhs.blue) < kEpsilon
        return rEqual && gEqual && bEqual
    }
}
