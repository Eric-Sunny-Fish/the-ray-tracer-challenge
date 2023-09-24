//
//  Color.swift
//  The Ray Tracer Challenge
//
//  Created by Eric Berna on 9/21/23.
//

import Foundation

struct Color {
    let r: Double
    let g: Double
    let b: Double
    
    static func + (lhs: Color, rhs: Color) -> Color {
        Color(r: lhs.r + rhs.r, g: lhs.g + rhs.g, b: lhs.b + rhs.b)
    }
    
    static func - (lhs: Color, rhs: Color) -> Color {
        Color(r: lhs.r - rhs.r, g: lhs.g - rhs.g, b: lhs.b - rhs.b)
    }
    
    static func * (lhs: Color, rhs: Double) -> Color {
        Color(r: lhs.r * rhs, g: lhs.g * rhs, b: lhs.b * rhs)
    }
    
    static func * (lhs: Color, rhs: Color) -> Color {
        Color(r: lhs.r * rhs.r, g: lhs.g * rhs.g, b: lhs.b * rhs.b)
    }

}

extension Color: Equatable {
    static func == (lhs: Color, rhs: Color) -> Bool {
        let epsilon = 1e-10
        let rEqual = abs(lhs.r - rhs.r) < epsilon
        let gEqual = abs(lhs.g - rhs.g) < epsilon
        let bEqual = abs(lhs.b - rhs.b) < epsilon
        return rEqual && gEqual && bEqual
    }
}
