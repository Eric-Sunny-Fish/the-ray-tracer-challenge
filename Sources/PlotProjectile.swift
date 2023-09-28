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

extension Canvas {
    mutating func plotSquare(x: Int, y: Int, color: Color) {
        write(x: x - 1, y: y - 1, color: color)
        write(x: x - 1, y: y, color: color)
        write(x: x - 1, y: y + 1, color: color)
        write(x: x, y: y - 1, color: color)
        write(x: x, y: y, color: color)
        write(x: x, y: y + 1, color: color)
        write(x: x + 1, y: y - 1, color: color)
        write(x: x + 1, y: y, color: color)
        write(x: x + 1, y: y + 1, color: color)
    }
}

@main
class PlotProjectile {
  static func main() {
      var p = Projectile(position: Tuple.point(0, 1, 0), velocity: Tuple.vector(1, 1.8, 0).unit * 11.25)
      let e = Environment(gravity: Tuple.vector(0, -0.1, 0), wind: Tuple.vector(-0.01, 0, 0))
      var c = Canvas(width: 900, height: 500)
      while p.position.y > 0 {
          p = tick(environment: e, projectile: p)
          c.plotSquare(
            x: Int(p.position.x),
            y: c.height - Int(p.position.y),
            color: Color(r: 0.4, g: 0.8, b: 0.4)
          )
      }
      c.saveToFile(name: "PlotProjectile")
  }
}
