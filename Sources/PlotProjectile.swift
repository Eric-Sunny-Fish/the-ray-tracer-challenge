//
//  main.swift
//  PlotProjectile
//
//  Created by Eric Berna on 9/23/23.
//

import Foundation
import TheRayTracerChallenge

struct Projectile {
    var position: Tuple
    var velocity: Tuple
}

struct Environment {
    var gravity: Tuple
    var wind: Tuple
}

func tick(environment: Environment, projectile: Projectile) -> Projectile {
    let position = projectile.position + projectile.velocity
    let velocity = projectile.velocity + environment.gravity + environment.wind
    return Projectile(position: position, velocity: velocity)
}

@main
enum PlotProjectile {
    static func main() {
        var projectile = Projectile(
            position: Tuple.point(0, 1, 0),
            velocity: Tuple.vector(1, 1.8, 0).unit * 11.25
        )
        let environment = Environment(gravity: Tuple.vector(0, -0.1, 0), wind: Tuple.vector(-0.01, 0, 0))
        var canvas = Canvas(width: 900, height: 500)
        while projectile.position.y > 0 {
            projectile = tick(environment: environment, projectile: projectile)
            canvas.plotSquare(
                x: Int(projectile.position.x),
                y: canvas.height - Int(projectile.position.y),
                color: Color(red: 0.4, green: 0.8, blue: 0.4)
            )
        }
        canvas.saveToFile(name: "PlotProjectile")
    }
}
