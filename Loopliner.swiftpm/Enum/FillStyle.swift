//
//  FillStyle.swift
//  Loopliner
//
//  Created by Lonard Steven on 22/01/25.
//

import SwiftUI

enum FillStyle {
    case color(color: Color)
    case gradient(gradient: Gradient, centerPosition: UnitPoint, startAngle: Angle, endAngle: Angle)
    
    func asShapeStyle() -> AnyShapeStyle {
        switch self {
        case .color(let color):
            return AnyShapeStyle(color)
        case .gradient(let gradient, let centerPosition, let startAngle, let endAngle):
            return AnyShapeStyle(AngularGradient(gradient: gradient, center: centerPosition, startAngle: startAngle, endAngle: endAngle))
        }
    }
}
