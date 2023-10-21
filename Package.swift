// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TheRayTracerChallenge",
    platforms: [.macOS(.v14)],
    dependencies: [
        .package(
            url: "https://github.com/realm/SwiftLint",
            from: "0.53.0"
        )
    ],
    targets: [
        .target(
            name: "TheRayTracerChallenge",
            path: "Sources",
            sources: [
                "Canvas.swift",
                "Color.swift",
                "Intersection.swift",
                "Matrix.swift",
                "Ray.swift",
                "Object.swift",
                "Transformations.swift",
                "Tuple.swift"
            ],
            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
        ),
        .executableTarget(
            name: "Tracer",
            dependencies: ["TheRayTracerChallenge"],
            path: "Sources",
            sources: ["main.swift"]
        ),
        .executableTarget(
            name: "Plot Projectile", 
            dependencies: ["TheRayTracerChallenge"],
            path: "Sources",
            sources: ["PlotProjectile.swift"],
            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
        ),
        .executableTarget(
            name: "ClockFace",
            dependencies: ["TheRayTracerChallenge"],
            path: "Sources",
            sources: ["ClockFace.swift"],
            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
        ),
        .executableTarget(
            name: "FlatSphere",
            dependencies: ["TheRayTracerChallenge"],
            path: "Sources",
            sources: ["FlatSphere.swift"],
            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
        ),
        .testTarget(
            name: "TheRayTracerChalengeTests", 
            dependencies: ["TheRayTracerChallenge"],
            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
        )
    ]
)
