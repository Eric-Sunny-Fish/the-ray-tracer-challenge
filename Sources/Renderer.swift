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
}
