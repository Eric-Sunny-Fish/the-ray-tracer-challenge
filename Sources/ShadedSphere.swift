//
//  FlatSphere.swift
//
//
//  Created by Eric Berna on 10/21/23.
//

import Foundation
import TheRayTracerChallenge

let kCanvasSize: Int = 200
let kOffset = 100
let kWallSize = 8.0
let kHalf = 4.0
let kWallPosition = 10.0
let kColor = Color(red: 0.9, green: 0.0, blue: 0.0)
let kSphere = Sphere(material: Material(color: Color(red: 1, green: 0.2, blue: 1)))
let kOrigin = Tuple.point(0, 0, -5)
let kLight = Light.point(position: Tuple.point(-10, 10, -10), intensity: Color(red: 1, green: 1, blue: 1))

@main
enum FlatSphere {
    static func main() {
        var canvas = Canvas(width: kCanvasSize, height: kCanvasSize)
        let pixelSize = kWallSize / Double(kCanvasSize)
        for row in 0..<kCanvasSize {
            let worldY = kHalf - pixelSize * Double(row)
            for column in 0..<kCanvasSize {
                let worldX = -kHalf + pixelSize * Double(column)
                let ray = Ray(origin: kOrigin, direction: Tuple.vector(worldX, worldY, kWallPosition).unit)
                let hit = ray.intersects(sphere: kSphere).hit()
                if let hit {
                    let point = ray.position(time: hit.time)
                    let normal = hit.object.normal(at: point)
                    let eye = -1 * ray.direction
                    let color = Renderer.lighting(
                        material: hit.object.material,
                        light: kLight,
                        position: point,
                        eyeVector: eye,
                        normalVector: normal
                    )
                    canvas.write(x: row, y: column, color: color)
                }
            }
        }
        canvas.saveToFile(name: "ShadedSphere")
    }
}
