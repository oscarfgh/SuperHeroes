//
//  Colors.swift
//  Superheroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    
    convenience init(rgbaValue: UInt32) {
        let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
        let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
        let blue  = CGFloat((rgbaValue >> 8) & 0xff) / 255.0
        let alpha = CGFloat((rgbaValue) & 0xff) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(named color: Color) {
        self.init(rgbaValue: color.rgbaValue)
    }
    
    func withAlpha(_ alpha: CGFloat = 1.0) -> UIColor {
        return withAlphaComponent(alpha)
    }
}

struct Color {
    
    let rgbaValue: UInt32
    var color: UIColor {
        return UIColor(named: self)
    }
    
    static let black = Color(rgbaValue: 0xff181818).color
    static let white = Color(rgbaValue: 0xffffffff).color
    static let primary = Color(rgbaValue: 0xed1b2aff).color
    static let secondary = Color(rgbaValue: 0xb2131eff).color
    
    static func color(named name: String) -> UIColor {
        switch name {
        case "black":
            return Color.black
        case "white":
            return Color.white
        case "primary":
            return Color.primary
        case "secondary":
            return Color.secondary
        default:
            return Color.black
        }
    }
}
