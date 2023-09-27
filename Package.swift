// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "The Ray Tracer Challenge",
    targets: [
        .target(
            name: "The Ray Tracer Challenge",
            path: "Sources",
            sources: [
                "Canvas.swift",
                "Color.swift",
                "Tuple.swift"
            ]),
        .executableTarget(
            name: "Tracer",
            dependencies: ["The Ray Tracer Challenge"],
            path: "Sources",
            sources: ["main.swift"]),
        .executableTarget(
            name: "Plot Projectile", 
            dependencies: ["The Ray Tracer Challenge"],
            path: "Sources",
            sources: ["PlotProjectile.swift"]),
        .testTarget(
            name: "The Ray Tracer Chalenge Tests", 
            dependencies: ["The Ray Tracer Challenge"])
    ]
)
