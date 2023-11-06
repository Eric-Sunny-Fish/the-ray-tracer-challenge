//
//  Material.swift
//
//
//  Created by Eric Berna on 10/21/23.
//

import Foundation

public struct Material: Equatable {
    let color: Color
    let ambient: Double
    let diffuse: Double
    let specular: Double
    let shininess: Double
    
    public init(
        color: Color = Color(red: 1, green: 1, blue: 1),
        ambient: Double = 0.1,
        diffuse: Double = 0.9,
        specular: Double = 0.9,
        shininess: Double = 200.0
    ) {
        self.color = color
        self.ambient = ambient
        self.diffuse = diffuse
        self.specular = specular
        self.shininess = shininess
    }
}
