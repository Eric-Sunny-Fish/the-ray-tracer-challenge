//
//  Ray.swift
//
//
//  Created by Eric Berna on 10/17/23.
//

import Foundation

public struct Ray: Equatable {
    let origin: Tuple
    let direction: Tuple
    
    public init(origin: Tuple, direction: Tuple) {
        self.origin = origin
        self.direction = direction
    }
    
    func position(time: Double) -> Tuple {
        origin + (direction * time)
    }
    
    public func intersects(_ sphere: Sphere) -> [Intersection] {
        guard let inverse = sphere.transform.inverse else {
            return []
        }
        let ray = self.transform(by: inverse)
        let sphereToRay = ray.origin - sphere.center
        let quadA = ray.direction • ray.direction
        let quadB = 2.0 * (ray.direction • sphereToRay)
        let quadC = (sphereToRay • sphereToRay) - 1.0
        let discriminant = quadB * quadB - 4 * quadA * quadC
        if discriminant < 0 {
            return []
        }
        let time1 = (-quadB - sqrt(discriminant)) / (2.0 * quadA)
        let time2 = (-quadB + sqrt(discriminant)) / (2.0 * quadA)
        let int1 = Intersection(time: time1, object: sphere)
        let int2 = Intersection(time: time2, object: sphere)
        return [int1, int2]
    }
    
    func transform(by matrix: Matrix) -> Self {
        Self(origin: matrix * self.origin, direction: matrix * self.direction)
    }
}
