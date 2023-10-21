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
let kSphere = Sphere()
let kOrigin = Tuple.point(0, 0, -5)

@main
enum FlatSphere {
    static func main() {
        var canvas = Canvas(width: kCanvasSize, height: kCanvasSize)
        let pixelSize = kWallSize / Double(kCanvasSize)
        for row in 0..<kCanvasSize {
            let worldY = kHalf - pixelSize * Double(row)
            for column in 0..<kCanvasSize {
                let worldX = -kHalf + pixelSize * Double(column)
                let ray = Ray(origin: kOrigin, direction: Tuple.vector(worldX, worldY, kWallPosition))
                let hit = ray.intersects(kSphere).hit()
                if hit != nil {
                    canvas.write(x: row, y: column, color: kColor)
                }
            }
        }
        canvas.saveToFile(name: "FlatSphere")
    }
}
