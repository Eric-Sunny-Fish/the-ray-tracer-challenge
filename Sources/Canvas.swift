//
//  Canvas.swift
//  The Ray Tracer Challenge
//
//  Created by Eric Berna on 9/22/23.
//

import Foundation

public struct Canvas {
    public let width: Int
    public let height: Int
    private var pixels: [[Color]]
    
    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
        self.pixels = Array<Array<Color>>(repeating: Array<Color>(repeating: Color(r: 0, g: 0, b: 0), count: width), count: height)
    }
    
    public mutating func write(x: Int, y: Int, color: Color) {
        guard x >= 0 && x < width && y >= 0 && y < height else {
            return
        }
        pixels[y][x] = color
    }
    
    func pixel(x: Int, y: Int) -> Color {
        pixels[y][x]
    }
    
    public func ppm() -> String {
        var result = "P3\n\(width) \(height)\n255\n"
        for row in pixels {
            var values = [Int]()
            for pixel in row {
                values.append(Int(min(max(pixel.r * 255, 0), 255)))
                values.append(Int(min(max(pixel.g * 255, 0), 255)))
                values.append(Int(min(max(pixel.b * 255, 0), 255)))
            }
            var rowString = ""
            for value in values {
                let next = "\(value) "
                if rowString.count + next.count > 70 {
                    result.append(rowString.trimmingCharacters(in: .whitespacesAndNewlines))
                    result.append("\n")
                    rowString = ""
                }
                rowString.append(next)
            }
            result.append(rowString.trimmingCharacters(in: .whitespacesAndNewlines))
            result.append("\n")
        }
        return result
    }
    
}
