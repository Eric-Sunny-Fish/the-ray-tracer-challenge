//
//  File.swift
//  
//
//  Created by Eric Berna on 10/9/23.
//
// swiftlint:disable no_magic_numbers

import Foundation
import TheRayTracerChallenge

let kCanvasSize = 200
let kOffset = 100

@main
enum ClockFace {
    static func main() {
        var canvas = Canvas(width: kCanvasSize, height: kCanvasSize)
        var point = Tuple.point(0, 0, 0)
        let translation = Matrix.translation(0, 80, 0)
        point = translation * point
        for _ in 1...12 {
            let rotation = Matrix.rotationZ((.pi / 6.0))
            point = rotation * point
            canvas.plotSquare(
                x: Int(point.x) + kOffset,
                y: Int(point.y) + kOffset,
                color: Color(red: 0.4, green: 0.8, blue: 0.4)
            )
        }
        canvas.saveToFile(name: "ClockFace")
    }
}

// swiftlint:enable no_magic_numbers
