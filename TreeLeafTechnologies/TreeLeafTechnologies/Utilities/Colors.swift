//
//  Colors.swift
//  TreeLeafTechnologies
//
//  Created by Preksha Dahal on 29/12/2023.
//

import UIKit
enum Color {
    case red
    case pink
    case green
    case blue
    case yellow
    case purple
    case orange
    case black
    case white
    case gray
    case opaque
    case transparent
}

extension UIColor {
    convenience init(_ color: Color) {
        switch color {
        case .red:
            self.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        case .pink:
            self.init(red: 1.0, green: 0.84, blue: 0.94, alpha: 1.0)
        case .green:
            self.init(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        case .blue:
            self.init(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        case .yellow:
            self.init(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
        case .purple:
            self.init(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
        case .orange:
            self.init(red: 1.0, green: 0.647, blue: 0.0, alpha: 1.0)
        case .black:
            self.init(white: 0.0, alpha: 1.0)
        case .white:
            self.init(white: 1.0, alpha: 1.0)
        case .gray:
            self.init(red: 0.921, green: 0.921, blue: 0.921, alpha: 01)
        case .opaque:
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8)
        case .transparent:
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1)
        }
    }
}
