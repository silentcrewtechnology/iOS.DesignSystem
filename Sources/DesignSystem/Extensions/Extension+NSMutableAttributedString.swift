//
//  Extension+NSMutableAttributedString.swift
//  
//
//  Created by firdavs on 01.06.2023.
//

import UIKit

extension NSMutableAttributedString {
    
    private func addingAttributes(
        _ attributes: [NSAttributedString.Key: Any],
        range: NSRange
    ) -> Self {
        addAttributes(attributes, range: range)
        return self
    }
    
    func addingAttributes(
        _ attributes: [NSAttributedString.Key: Any]
    ) -> Self {
        addingAttributes(attributes, range: fullRange())
    }
    
    func foregroundColor(_ color: UIColor) -> Self {
        addingAttributes([.foregroundColor: color])
    }
    
    func foregroundColor(_ color: UIColor, for string: String) -> Self {
        let range = stringRange(with: string)
        let attribute = addingAttributes([.foregroundColor: color], range: range)
        return attribute
    }
    
    func font(_ font: UIFont) -> Self {
        addingAttributes([.font: font])
    }
    
    private var existingParagraphStyle: NSMutableParagraphStyle {
        var effectiveRange = fullRange()
        let existingParagraphStyle = attribute(
            .paragraphStyle,
            at: 0,
            effectiveRange: &effectiveRange
        ) as? NSMutableParagraphStyle
        return existingParagraphStyle ?? .init()
    }
    
    func lineHeight(_ lineHeight: CGFloat) -> Self {
        let paragraphStyle = existingParagraphStyle
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        return addingAttributes([.paragraphStyle: paragraphStyle])
    }
    
    func alignment(_ alignment: NSTextAlignment) -> Self {
        let paragraphStyle = existingParagraphStyle
        paragraphStyle.alignment = alignment
        return addingAttributes([.paragraphStyle: paragraphStyle])
    }
    
    func kern(_ spacing: CGFloat) -> Self {
        addingAttributes([.kern: spacing])
    }
    
    func baselineOffset(_ offset: CGFloat) -> Self {
        addingAttributes([.baselineOffset: offset])
    }
    
    func fontStyle(_ style: FontStyle) -> Self {
        return self
            .font(style.font)
            .lineHeight(style.lineHeight)
            .baselineOffset(style.baselineOffset)
    }
}
