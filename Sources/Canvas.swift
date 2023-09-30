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
        self.pixels = [[Color]](
            repeating: [Color](repeating: Color(red: 0, green: 0, blue: 0), count: width),
            count: height
        )
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
        let maxIntensity: Double = 255
        let minIntensity: Double = 0
        let maxLineLength: Int = 70
        var result = "P3\n\(width) \(height)\n255\n"
        for row in pixels {
            var values = [Int]()
            for pixel in row {
                values.append(Int(min(max(pixel.red * maxIntensity, minIntensity), maxIntensity)))
                values.append(Int(min(max(pixel.green * maxIntensity, minIntensity), maxIntensity)))
                values.append(Int(min(max(pixel.blue * maxIntensity, minIntensity), maxIntensity)))
            }
            var rowString = ""
            for value in values {
                let next = "\(value) "
                if rowString.count + next.count > maxLineLength {
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
    
    public func saveToFile(name: String) {
        let string = self.ppm()
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Could not save file")
            return
        }
        let filename = path.appendingPathComponent("\(name).ppm")
        do {
            try string.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Could not save file")
        }
    }
}
