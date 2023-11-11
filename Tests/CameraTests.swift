//
//  CameraTests.swift
//  
//
//  Created by Eric Berna on 11/9/23.
//

import XCTest
@testable import TheRayTracerChallenge

final class CameraTests: XCTestCase {
    func testConstructCamera() {
        let hSize = 160
        let vSize = 120
        let fieldOfView = .pi / 2.0
        let camera = Camera(hSize: hSize, vSize: vSize, fieldOfView: fieldOfView)
        XCTAssertEqual(camera.hSize, hSize)
        XCTAssertEqual(camera.vSize, vSize)
        XCTAssertEqual(camera.fieldOfView, fieldOfView)
        XCTAssertEqual(camera.transform, Matrix.identity)
    }
    
    func testPixelSizeHorizontalCamera() {
        let camera = Camera(hSize: 200, vSize: 125, fieldOfView: .pi / 2)
        XCTAssertEqual(camera.pixelSize, 0.01, accuracy: 0.00001)
    }
    
    func testPixelSizeVerticalCamera() {
        let camera = Camera(hSize: 125, vSize: 200, fieldOfView: .pi / 2)
        XCTAssertEqual(camera.pixelSize, 0.01, accuracy: 0.00001)
    }
    
    func testRayThroughCameraCenter() {
        let camera = Camera(hSize: 201, vSize: 101, fieldOfView: .pi / 2)
        let ray = camera.rayForPixel(x: 100, y: 50)
        let expected = Ray(origin: Tuple.point(0, 0, 0), direction: Tuple.vector(0, 0, -1))
        XCTAssertEqual(ray, expected)
    }
    
    func testRayThroughCameraCorner() {
        let camera = Camera(hSize: 201, vSize: 101, fieldOfView: .pi / 2)
        let ray = camera.rayForPixel(x: 0, y: 0)
        let expected = Ray(origin: Tuple.point(0, 0, 0), direction: Tuple.vector(0.66519, 0.33259, -0.66851))
        XCTAssertEqual(ray, expected)
    }
    
    func testRayWhenCameraTransformed() {
        let transform = Matrix.rotationY(.pi / 4) * Matrix.translation(0, -2, 5)
        let camera = Camera(hSize: 201, vSize: 101, fieldOfView: .pi / 2, transform: transform)
        let ray = camera.rayForPixel(x: 100, y: 50)
        let expected = Ray(
            origin: Tuple.point(0, 2, -5),
            direction: Tuple.vector(sqrt(2) / 2, 0, -sqrt(2) / 2)
        )
        XCTAssertEqual(ray, expected)
    }
    
    func testRenderingWorldWithCamera() {
        let world = World.standard()
        let from = Tuple.point(0, 0, -5)
        // swiftlint:disable:next identifier_name
        let to = Tuple.point(0, 0, 0)
        // swiftlint:disable:next identifier_name
        let up = Tuple.vector(0, 1, 0)
        let transform = Matrix.viewTransform(from: from, to: to, up: up)
        let camera = Camera(hSize: 11, vSize: 11, fieldOfView: .pi / 2, transform: transform)
        let image: Canvas = camera.render(world: world)
        let expected = Color(red: 0.38066, green: 0.47583, blue: 0.2855)
        XCTAssertEqual(image.pixel(x: 5, y: 5), expected)
    }
}
