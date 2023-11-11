//
//  World.swift
//
//
//  Created by Eric Berna on 11/6/23.
//

import Foundation

public struct World {
    public var objects: [Sphere]
    public var lights: [Light]
    
    public init(objects: [Sphere] = [], lights: [Light] = []) {
        self.objects = objects
        self.lights = lights
    }
    
    public static func standard() -> Self {
        let light = Light.point(
            position: Tuple.point(-10, 10, -10),
            intensity: Color(red: 1, green: 1, blue: 1)
        )
        let sphere1 = Sphere(
            material: Material(color: Color(red: 0.8, green: 1.0, blue: 0.6), diffuse: 0.7, specular: 0.2)
        )
        let sphere2 = Sphere(transform: Matrix.scale(0.5, 0.5, 0.5))
        return Self(objects: [sphere1, sphere2], lights: [light])
    }
}
