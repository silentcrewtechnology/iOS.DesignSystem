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
        case title
        case subtitle
        case index
        case amount
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
        case .title:
            fontStyle = .textM
            foregroundColor = .contentPrimary
            inset = .zero
        case .subtitle, .index:
            inset = .zero
        case .amount:
            fontStyle = .textM_1
            foregroundColor = .contentPrimary
            inset = .zero
        case .default:
            /// Пока что выглядят одинаково с subtitle и index
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
