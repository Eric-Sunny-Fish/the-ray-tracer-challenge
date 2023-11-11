//
//  Light.swift
//
//
//  Created by Eric Berna on 10/21/23.
//

import Foundation

public struct Light: Equatable {
    let position: Tuple
    let intensity: Color
    
    public static func point(position: Tuple, intensity: Color) -> Self {
        Self(position: position, intensity: intensity)
    }
}
