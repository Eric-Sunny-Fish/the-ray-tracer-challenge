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
    public let point: Tuple
    public let eyev: Tuple
    public let normalv: Tuple
    public let inside: Bool
    
    public init(
        time: Double,
        object: Sphere,
        point: Tuple = Tuple.point(0, 0, 0),
        eyev: Tuple = Tuple.zeroVector,
        normalv: Tuple = Tuple.zeroVector,
        inside: Bool = false
    ) {
        self.time = time
        self.object = object
        self.point = point
        self.eyev = eyev
        self.normalv = normalv
        self.inside = inside
    }
    
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
