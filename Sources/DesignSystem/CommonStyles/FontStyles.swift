//
//  FontStyle.swift
//  
//
//  Created by firdavs on 01.06.2023.
//
import FontService
import UIKit

public struct FontStyle {
    /// Шрифт
    let font: UIFont
    /// Высота строки
    let lineHeight: CGFloat
    /// Отступ снизу для центрирования текста по вертикали
    var baselineOffset: CGFloat {
        let offset = (lineHeight - font.capHeight) / 2 + font.descender
        if #available(iOS 16.4, *) {
            return offset
        } else {
            return offset / 2
        }
    }
    
    // MARK: Heading
    
    static let heading4XL = Self(
        font: .heading4XL,
        lineHeight: 64)
    
    static let heading3XL = Self(
        font: .heading3XL,
        lineHeight: 56)
    
    static let heading2XL = Self(
        font: .heading2XL,
        lineHeight: 40)
    
    static let headingXL  = Self(
        font: .headingXL,
        lineHeight: 32)
    
    // MARK: Text
    
    static let text4XL = Self(
        font: .text4XL,
        lineHeight: 56)
    
    static let text4XL_1 = Self(
        font: .text4XL_1,
        lineHeight: 56)
    
    static let text3XL = Self(
        font: .text3XL,
        lineHeight: 40)
    
    static let text3XL_1 = Self(
        font: .text3XL_1,
        lineHeight: 40)
    
    static let text2XL = Self(
        font: .text2XL,
        lineHeight: 36)
    
    static let text2XL_1 = Self(
        font: .text2XL_1,
        lineHeight: 36)
    
    static let textXL = Self(
        font: .textXL,
        lineHeight: 32)
    
    static let textXL_1 = Self(
        font: .textXL_1,
        lineHeight: 32)
    
    static let textL = Self(
        font: .textL,
        lineHeight: 28)
    
    static let textL_1 = Self(
        font: .textL_1,
        lineHeight: 28)
    
    static let textM = Self(
        font: .textM,
        lineHeight: 24)
    
    static let textM_1 = Self(
        font: .textM_1,
        lineHeight: 24)
    
    static let textS = Self(
        font: .textS,
        lineHeight: 20)
    
    static let textS_1 = Self(
        font: .textS_1,
        lineHeight: 20)
    
    static let textXS = Self(
        font: .textXS,
        lineHeight: 16)
    
    static let textXS_1 = Self(
        font: .textXS_1,
        lineHeight: 16)
    
    static let text2XS = Self(
        font: .text2XS,
        lineHeight: 16)
    
    static let text2XS_1 = Self(
        font: .text2XS_1,
        lineHeight: 16)
    
    static let text3XS = Self(
        font: .text3XS,
        lineHeight: 16)
    
    static let text3XS_1 = Self(
        font: .text3XS_1,
        lineHeight: 16)
    
    // MARK: Caption
    
    static let caption3XS = Self(
        font: .caption3XS,
        lineHeight: 16)
    
    static let caption3XS_1 = Self(
        font: .caption3XS_1,
        lineHeight: 16)
}
