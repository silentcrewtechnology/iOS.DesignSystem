//
//  AuthorizationButtonStyle.swift
//
//
//  Created by Ilnur Mugaev on 21.03.2024.
//

import UIKit
import Components

public struct AuthorizationButtonStyle {
    
    public enum Variant {
        case standart
        case gosuslugi
    }
    
    private let variant: Variant
    private let isInversed: Bool
    
    public init(
        variant: Variant,
        isInversed: Bool = false
    ) {
        self.variant = variant
        self.isInversed = isInversed
    }
    
    public func update(
        viewProperties: inout AuthorizationButton.ViewProperties
    ) {
        viewProperties.title = viewProperties.title
            .fontStyle(.textM)
            .foregroundColor(titleColor())
        
        viewProperties.backgroundColor = backgroundColor()
        viewProperties.highlightedColor = highlightedColor()
        viewProperties.spacing = spacing()
        
        if case .standart = variant {
            viewProperties.image = viewProperties.image
                .withTintColor(isInversed ? .contentAction : .contentActionOn)
        }
    }
}

public extension AuthorizationButtonStyle {
    
    func titleColor() -> UIColor {
        switch variant {
        case .standart:
            return isInversed ? .contentPrimary : .contentActionOn
        case .gosuslugi:
            return .gosuslugiButtonTitle
        }
    }
    
    func backgroundColor() -> UIColor {
        switch variant {
        case .standart:
            return isInversed ? .backgroundMain : .backgroundAction
        case .gosuslugi:
            return isInversed ? .backgroundMain : .backgroundInfoLight
        }
    }
    
    func highlightedColor() -> UIColor {
        switch variant {
        case .standart:
            return isInversed ? .backgroundMainPressed : .backgroundActionPressed
        case .gosuslugi:
            return isInversed ? .backgroundMainPressed : .backgroundInfoLightPressed
        }
    }
    
    func spacing() -> CGFloat {
        switch variant {
        case .standart: 16
        case .gosuslugi: 8
        }
    }
}
