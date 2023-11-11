//
//  Renderer.swift
//
//
//  Created by Eric Berna on 10/21/23.
//

import Foundation

public enum Renderer {
    public static func lighting(
        material: Material,
        light: Light,
        position: Tuple,
        eyeVector: Tuple,
        normalVector: Tuple
    ) -> Color {
        let effectiveColor = material.color * light.intensity
        let lightVector = (light.position - position).unit
        let ambient = effectiveColor * material.ambient
        let lightDotNormal = lightVector • normalVector
        var diffuse = Color.black
        var specular = Color.black
        if lightDotNormal > 0 {
            diffuse = effectiveColor * material.diffuse * lightDotNormal
            let reflectVector = -lightVector.reflect(around: normalVector)
            let reflectDotEye = reflectVector • eyeVector
            if reflectDotEye > 0 {
                let factor = pow(reflectDotEye, material.shininess)
                specular = light.intensity * material.specular * factor
            }
        }
        return ambient + diffuse + specular
    }
    
    public static func shadeHit(world: World, intersection: Intersection) -> Color {
        var result = Color.black
        for light in world.lights {
            // swiftlint:disable:next shorthand_operator
            result = result + Self.lighting(
                material: intersection.object.material,
                light: light,
                position: intersection.point,
                eyeVector: intersection.eyev,
                normalVector: intersection.normalv
            )
        }
        return result
    }
    
    public static func color(world: World, ray: Ray) -> Color {
        let intersections = ray.intersects(world: world)
        guard let hit = intersections.hit() else {
            return Color.black
        }
        return Self.shadeHit(world: world, intersection: hit)
    }
}
