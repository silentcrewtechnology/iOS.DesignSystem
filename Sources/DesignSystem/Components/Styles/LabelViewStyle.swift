//
//  LabelViewStyle.swift
//
//
//  Created by Ilnur Mugaev on 17.04.2024.
//

import UIKit
import Components

public struct LabelViewStyle {
    public enum Variant {
        case `default`
        case title(isCopied: Bool)
        case subtitle
        case index
        case amount
        case subindex
    }
    
    public var variant: Variant
    
    public init(variant: Variant) {
        self.variant = variant
    }
    
    public func update(
        viewProperties: inout LabelView.ViewProperties
    ) {
        var fontStyle: FontStyle = .textS
        var foregroundColor: UIColor = .contentSecondary
        var inset: UIEdgeInsets = .init(top: 2, left: 0, bottom: 2, right: 0)
        switch variant {
        case .title(let copied):
            fontStyle = .textM
            foregroundColor = .contentPrimary
            inset = .zero
            viewProperties.isCopied = copied
            /// Можем копировать только title
        case .subtitle, .index:
            inset = .zero
            viewProperties.isCopied = false
        case .amount:
            fontStyle = .textM_1
            foregroundColor = .contentPrimary
            inset = .zero
            viewProperties.isCopied = false
        case .subindex:
            fontStyle = .text2XS
            inset = .zero
            viewProperties.isCopied = false
        case .default:
            /// Пока что выглядят одинаково с subtitle и index
            viewProperties.isCopied = false
            break
        }
        
        viewProperties.text = viewProperties.text
            .fontStyle(fontStyle)
            .foregroundColor(foregroundColor)
        viewProperties.size = .init(
            inset: inset,
            lineHeight: fontStyle.lineHeight
        )
    }
}
