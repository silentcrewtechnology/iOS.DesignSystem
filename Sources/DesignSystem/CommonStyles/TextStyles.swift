//
//  CommonTextStyles.swift
//  
//
//  Created by firdavs on 02.06.2023.
//

import UIKit

public enum CommonTextStyles {
    
    case text4XL(String, UIColor)
    case text4XL_1(String, UIColor)
    case text3XL(String, UIColor)
    case text3XL_1(String, UIColor)
    case text2XL(String, UIColor)
    case text2XL_1(String, UIColor)
    case textXL(String, UIColor)
    case textXL_1(String, UIColor)
    case textL(String, UIColor)
    case textL_1(String, UIColor)
    case textM(String, UIColor)
    case textM_1(String, UIColor)
    case textS(String, UIColor)
    case textS_1(String, UIColor)
    case textXS(String, UIColor)
    case textXS_1(String, UIColor)
    case text2XS(String, UIColor)
    case text2XS_1(String, UIColor)
    case text3XS(String, UIColor)
    case text3XS_1(String, UIColor)
    
    public func text() -> NSAttributedString {
        switch self {
        case .text4XL(let string, let uIColor):
            return string.text4XL(color: uIColor)
        case .text4XL_1(let string, let uIColor):
            return string.text4XL_1(color: uIColor)
        case .text3XL(let string, let uIColor):
            return string.text3XL(color: uIColor)
        case .text3XL_1(let string, let uIColor):
            return string.text3XL_1(color: uIColor)
        case .text2XL(let string, let uIColor):
            return string.text2XL(color: uIColor)
        case .text2XL_1(let string, let uIColor):
            return string.text2XL_1(color: uIColor)
        case .textXL(let string, let uIColor):
            return string.textXL(color: uIColor)
        case .textXL_1(let string, let uIColor):
            return string.textXL_1(color: uIColor)
        case .textL(let string, let uIColor):
            return string.textL(color: uIColor)
        case .textL_1(let string, let uIColor):
            return string.textL_1(color: uIColor)
        case .textM(let string, let uIColor):
            return string.textM(color: uIColor)
        case .textM_1(let string, let uIColor):
            return string.textM_1(color: uIColor)
        case .textS(let string, let uIColor):
            return string.textS(color: uIColor)
        case .textS_1(let string, let uIColor):
            return string.textS_1(color: uIColor)
        case .textXS(let string, let uIColor):
            return string.textXS(color: uIColor)
        case .textXS_1(let string, let uIColor):
            return string.textXS_1(color: uIColor)
        case .text2XS(let string, let uIColor):
            return string.text2XS(color: uIColor)
        case .text2XS_1(let string, let uIColor):
            return string.text2XS_1(color: uIColor)
        case .text3XS(let string, let uIColor):
            return string.text3XS(color: uIColor)
        case .text3XS_1(let string, let uIColor):
            return string.text3XS_1(color: uIColor)
        }
    }
}
