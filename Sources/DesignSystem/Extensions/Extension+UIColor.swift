//
//  Extension+UIColor.swift
//  
//
//  Created by firdavs on 13.06.2023.
//
import ColorService
import UIKit

public extension UIColor {
    
    static var backgroundErrorLight: UIColor {
        return ColorService.hexFFE5DD
    }
    
    static var backgroundWarningLight: UIColor {
        return ColorService.hexFFF5D9
    }
    
    static var backgroundSuccessLight: UIColor {
        return ColorService.hexE6FBD9
    }
    
    static var backgroundInfoLight: UIColor {
        return ColorService.hexE1F2FF
    }
    
    static var backgroundSecondary: UIColor {
        return ColorService.hexE8E8E8
    }

    static var contentInfo: UIColor {
        return ColorService.hex2B82E9
    }
    
    static var contenWarning: UIColor {
        return ColorService.hexFB9100
    }
    
    static var contentPrimary: UIColor {
        return ColorService.hex2C2C2C
    }
    
    static var contentSuccess: UIColor {
        return ColorService.hex82AF1A
    }
    
    static var contentError: UIColor {
        return ColorService.hexEE3D32
    }
    
    static var contentAction: UIColor {
        return ColorService.hex19AB4A
    }
}

