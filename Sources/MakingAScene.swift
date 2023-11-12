//
//  MakingAScene.swift
//
//
//  Created by Eric Berna on 10/21/23.
//

import Foundation
import TheRayTracerChallenge

let kFloor = Sphere(
    transform: .scale(10, 0.01, 10),
    material: Material(
        color: Color(red: 1, green: 0.9, blue: 0.9),
        specular: 0
    )
)
let kLeftWall = Sphere(
    transform: .translation(0, 0, 5) *
        .rotationY(-.pi / 4) *
        .rotationX(.pi / 2) *
        .scale(10, 0.01, 10),
    material: Material(
        color: Color(red: 1, green: 0.9, blue: 0.9),
        specular: 0
    )
)
let kRightWall = Sphere(
    transform: .translation(0, 0, 5) *
        .rotationY(.pi / 4) *
        .rotationX(.pi / 2) *
        .scale(10, 0.01, 10),
    material: Material(
        color: Color(red: 1, green: 0.9, blue: 0.9),
        specular: 0
    )
)
let kMiddle = Sphere(
    transform: .translation(-0.5, 1, 0.5),
    material: Material(
        color: Color(red: 0.1, green: 1, blue: 0.5),
        diffuse: 0.7,
        specular: 0.3
    )
)
let kRight = Sphere(
    transform: .translation(1.5, 0.5, -0.5)
        * .scale(0.5, 0.5, 0.5),
    material: Material(
        color: Color(red: 0.5, green: 1, blue: 0.1),
        diffuse: 0.7,
        specular: 0.3
    )
)
let kLeft = Sphere(
    transform: .translation(-1.5, 0.33, -0.75) * .scale(0.33, 0.33, 0.33),
    material: Material(
        color: Color(red: 1, green: 0.8, blue: 0.1),
        diffuse: 0.7,
        specular: 0.3
    )
)

@main
enum MakingAScene {
    static func main() {
        let world = World(
            objects: [kFloor, kRightWall, kLeftWall, kMiddle, kRight, kLeft],
            lights: [
                Light.point(
                    position: .point(-10, 10, -10),
                    intensity: Color(red: 1, green: 1, blue: 1)
                )
            ]
        )
        let from = Tuple.point(0, 1.5, -5)
        // swiftlint:disable:next identifier_name
        let to = Tuple.point(0, 1, 0)
        // swiftlint:disable:next identifier_name
        let up = Tuple.vector(0, 1, 0)
        let transform = Matrix.viewTransform(from: from, to: to, up: up)
        let camera = Camera(hSize: 200, vSize: 100, fieldOfView: .pi / 3, transform: transform)
        let image: Canvas = camera.render(world: world)
        image.saveToFile(name: "MakingAScene")
    }
}
