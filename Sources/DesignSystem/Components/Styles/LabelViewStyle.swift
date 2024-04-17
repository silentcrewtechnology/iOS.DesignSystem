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
        case `default`(NSMutableAttributedString)
        case none
    }
    
    private let variant: Variant
    
    public init(variant: Variant) {
        self.variant = variant
    }
    
    public func update(
        viewProperties: inout LabelView.ViewProperties
    ) {
        let fontStyle: FontStyle = .textS
        
        viewProperties.text = variant.text()?
            .fontStyle(fontStyle)
            .foregroundColor(.contentSecondary)
        
        viewProperties.size = .init(
            inset: .init(top: 4, left: 0, bottom: 4, right: 0),
            lineHeight: fontStyle.lineHeight
        )
    }
}

public extension LabelViewStyle.Variant {
    
    func text() -> NSMutableAttributedString? {
        switch self {
        case .default(let text): text
        case .none: nil
        }
    }
}
