//
//  Extension+UIColor.swift
//  
//
//  Created by firdavs on 13.06.2023.
//
import ColorService
import UIKit

public extension UIColor {
    
    // MARK: content
    
    static var contentAction: UIColor {
        return ColorService.contentAction
    }
    
    static var contentError: UIColor {
        return ColorService.contentError
    }
    
    static var contentInfo: UIColor {
        return ColorService.contentInfo
    }
    
    static var contentPrimary: UIColor {
        return ColorService.contentPrimary
    }
    
    static var contentSuccess: UIColor {
        return ColorService.contentSuccess
    }

    static var contentWarning: UIColor {
        return ColorService.contentWarning
    }
    
    // MARK: background
    
    static var backgroundErrorLight: UIColor {
        return ColorService.backgroundErrorLight
    }
    
    static var backgroundInfoLight: UIColor {
        return ColorService.backgroundInfoLight
    }
    
    static var backgroundSecondary: UIColor {
        return ColorService.backgroundSecondary
    }
    
    static var backgroundSuccessLight: UIColor {
        return ColorService.backgroundSuccessLight
    }
    
    static var backgroundWarningLight: UIColor {
        return ColorService.backgroundWarningLight
    }
}

