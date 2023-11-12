//
//  Camera.swift
//
//
//  Created by Eric Berna on 11/9/23.
//

import Foundation

public struct Camera {
    public let hSize: Int
    public let vSize: Int
    public let fieldOfView: Double
    public let transform: Matrix
    public let pixelSize: Double
    private let halfWidth: Double
    private let halfHeight: Double
    
    public init(
        hSize: Int,
        vSize: Int,
        fieldOfView: Double,
        transform: Matrix = Matrix.identity
    ) {
        self.hSize = hSize
        self.vSize = vSize
        self.fieldOfView = fieldOfView
        self.transform = transform.inverse ?? Matrix.identity
        let halfView = tan(fieldOfView / 2)
        let aspect = Double(hSize) / Double(vSize)
        if aspect >= 1 {
            self.halfWidth = halfView
            self.halfHeight = halfView / aspect
        } else {
            halfWidth = halfView * aspect
            self.halfHeight = halfView * aspect
        }
        self.pixelSize = (self.halfWidth * 2) / Double(hSize)
    }
    
    public func rayForPixel(x: Int, y: Int) -> Ray {
        let xOffset = (Double(x) + 0.5) * pixelSize
        let yOffset = (Double(y) + 0.5) * pixelSize
        let worldX = halfWidth - xOffset
        let worldY = halfHeight - yOffset
        let pixel = transform * Tuple.point(worldX, worldY, -1)
        let origin = transform * Tuple.point(0, 0, 0)
        let direction = (pixel - origin).unit
        return Ray(origin: origin, direction: direction)
    }
    
    public func render(world: World) -> Canvas {
        var result = Canvas(width: hSize, height: vSize)
        for y in 0..<vSize {
            for x in 0..<hSize {
                let ray = rayForPixel(x: x, y: y)
                let color = color(world: world, ray: ray)
                result.write(x: x, y: y, color: color)
            }
        }
        return result
    }
    
    public func lighting(
        material: Material,
        light: Light,
        position: Tuple,
        eyeVector: Tuple,
        normalVector: Tuple,
        inShadow: Bool = false
    ) -> Color {
        let effectiveColor = material.color * light.intensity
        let lightVector = (light.position - position).unit
        let ambient = effectiveColor * material.ambient
        let lightDotNormal = lightVector • normalVector
        var diffuse = Color.black
        var specular = Color.black
        if lightDotNormal > 0 && !inShadow {
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
    
    public func shadeHit(world: World, intersection: Intersection) -> Color {
        var result = Color.black
        for light in world.lights {
            let shadowed = world.isShadowed(point: intersection.overPoint)
            // swiftlint:disable:next shorthand_operator
            result = result + lighting(
                material: intersection.object.material,
                light: light,
                position: intersection.point,
                eyeVector: intersection.eyev,
                normalVector: intersection.normalv,
                inShadow: shadowed
            )
        }
        return result
    }
    
    public func color(world: World, ray: Ray) -> Color {
        let intersections = ray.intersects(world: world)
        guard let hit = intersections.hit() else {
            return Color.black
        }
        return shadeHit(world: world, intersection: hit)
    }
}
