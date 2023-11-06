//
//  Intersection.swift
//
//
//  Created by Eric Berna on 10/19/23.
//

import Foundation

public struct Intersection: Equatable {
    public let time: Double
    public let object: Sphere
    
    public static func intersections(_ ints: Self...) -> [Self] {
        Array(ints)
    }
}

extension Array where Element == Intersection {
    public func hit() -> Intersection? {
        var result: Intersection?
        var close = Double.infinity
        for item in self {
            if item.time > 0 && close > item.time {
                result = item
                close = item.time
            }
        }
        return result
    }
}
