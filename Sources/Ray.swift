//
//  Ray.swift
//
//
//  Created by Eric Berna on 10/17/23.
//

import Foundation

public struct Ray: Equatable {
    let origin: Tuple
    public let direction: Tuple
    
    public init(origin: Tuple, direction: Tuple) {
        self.origin = origin
        self.direction = direction
    }
    
    public func position(time: Double) -> Tuple {
        origin + (direction * time)
    }
    
    public func intersects(sphere: Sphere) -> [Intersection] {
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
        let point1 = self.position(time: time1)
        let point2 = self.position(time: time2)
        let eyev = -self.direction
        var normalv1 = sphere.normal(at: point1)
        var normalv2 = sphere.normal(at: point2)
        var inside1 = false
        var inside2 = false
        var overPoint1 = point1 + normalv1 * kEpsilon
        var overPoint2 = point2 + normalv2 * kEpsilon
        if (normalv1 • eyev) < 0 {
            inside1 = true
            normalv1 = -normalv1
        }
        if (normalv2 • eyev) < 0 {
            inside2 = true
            normalv2 = -normalv2
        }
        let int1 = Intersection(
            time: time1,
            object: sphere,
            point: point1,
            eyev: eyev,
            normalv: normalv1,
            inside: inside1,
            overPoint: overPoint1
        )
        let int2 = Intersection(
            time: time2,
            object: sphere,
            point: point2,
            eyev: eyev,
            normalv: normalv2,
            inside: inside2,
            overPoint: overPoint2
        )
        return [int1, int2]
    }
    
    public func intersects(world: World) -> [Intersection] {
        var result = [Intersection]()
        for sphere in world.objects {
            result += self.intersects(sphere: sphere)
        }
        result.sort { $0.time < $1.time }
        return result
    }
    
    func transform(by matrix: Matrix) -> Self {
        Self(origin: matrix * self.origin, direction: matrix * self.direction)
    }
}
