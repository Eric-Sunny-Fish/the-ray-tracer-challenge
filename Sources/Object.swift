//
//  Object.swift
//
//
//  Created by Eric Berna on 10/19/23.
//

import Foundation

public struct Sphere: Object {
    public var transform: Matrix
    let center: Tuple
    let radius: Double
    
    public init(center: Tuple = Tuple.point(0, 0, 0), radius: Double = 1, transform: Matrix = .identity) {
        self.center = center
        self.radius = radius
        self.transform = transform
    }
}

public protocol Object: Equatable {
    var transform: Matrix { get set }
}
