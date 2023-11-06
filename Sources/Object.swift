//
//  Object.swift
//
//
//  Created by Eric Berna on 10/19/23.
//

import Foundation

public struct Sphere: Object {
    public var transform: Matrix
    public var material: Material
    let center: Tuple
    let radius: Double
    
    public init(
        center: Tuple = Tuple.point(0, 0, 0),
        radius: Double = 1,
        transform: Matrix = .identity,
        material: Material = Material()
    ) {
        self.center = center
        self.radius = radius
        self.transform = transform
        self.material = material
    }
    
    public func normal(at point: Tuple) -> Tuple {
        let result: Tuple
        if let inverse = self.transform.inverse {
            let objectPoint = inverse * point
            result = (inverse.transpose * objectPoint).unit
        } else {
            result = point.unit
        }
        return result
    }
}

public protocol Object: Equatable {
    var transform: Matrix { get set }
    var material: Material { get set }
}
