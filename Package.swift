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
                "Light.swift",
                "Material.swift",
                "Matrix.swift",
                "Ray.swift",
                "Renderer.swift",
                "Object.swift",
                "Transformations.swift",
                "Tuple.swift"
            ],
            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
        ),
        // There appears to be a bug in Xcode that confuses
        // it when there are plenty of executable targets.
        // So I comment them out unless I want to run one
        // of them.
        //        .executableTarget(
        //            name: "Tracer",
        //            dependencies: ["TheRayTracerChallenge"],
        //            path: "Sources",
        //            sources: ["main.swift"]
        //        ),
        //        .executableTarget(
        //            name: "Plot Projectile",
        //            dependencies: ["TheRayTracerChallenge"],
        //            path: "Sources",
        //            sources: ["PlotProjectile.swift"],
        //            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
        //        ),
        //        .executableTarget(
        //            name: "ClockFace",
        //            dependencies: ["TheRayTracerChallenge"],
        //            path: "Sources",
        //            sources: ["ClockFace.swift"],
        //            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
        //        ),
        //        .executableTarget(
        //            name: "FlatSphere",
        //            dependencies: ["TheRayTracerChallenge"],
        //            path: "Sources",
        //            sources: ["FlatSphere.swift"],
        //            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
        //        ),
            .executableTarget(
                name: "ShadedSphere",
                dependencies: ["TheRayTracerChallenge"],
                path: "Sources",
                sources: ["ShadedSphere.swift"],
                plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
            ),
        .testTarget(
            name: "TheRayTracerChalengeTests",
            dependencies: ["TheRayTracerChallenge"],
            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
        )
    ]
)
