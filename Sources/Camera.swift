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
                let color = Renderer.color(world: world, ray: ray)
                result.write(x: x, y: y, color: color)
            }
        }
        return result
    }
}
