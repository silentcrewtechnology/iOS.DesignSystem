//
//  AuthorizationButtonStyle.swift
//
//
//  Created by Ilnur Mugaev on 21.03.2024.
//

import UIKit
import Components

public enum AuthorizationButtonStyle {
    
    public enum Style {
        case standart
        case gosuslugi
    }
    
    public static func update(
        style: Style,
        isInversed: Bool = false,
        viewProperties: AuthorizationButton.ViewProperties
    ) -> AuthorizationButton.ViewProperties {
        var viewProperties = viewProperties
        
        switch style {
        case .standart:
            viewProperties = updateForStyleStandart(isInversed: isInversed, viewProperties: viewProperties)
        case .gosuslugi:
            viewProperties = updateForStyleGosuslugi(isInversed: isInversed, viewProperties: viewProperties)
        }
        
        return viewProperties
    }
    
    private static func updateForStyleStandart(
        isInversed: Bool,
        viewProperties: AuthorizationButton.ViewProperties
    ) -> AuthorizationButton.ViewProperties {
        var viewProperties = viewProperties
        
        if isInversed {
            viewProperties.title = viewProperties.title.foregroundColor(.contentPrimary)
            viewProperties.image = viewProperties.image.tinted(with: .contentAction)
            viewProperties.backgroundColor = .backgroundMain
            viewProperties.highlightedColor = .backgroundMainPressed
        } else {
            viewProperties.title = viewProperties.title.foregroundColor(.contentActionOn)
            viewProperties.image = viewProperties.image.tinted(with: .contentActionOn)
            viewProperties.backgroundColor = .backgroundAction
            viewProperties.highlightedColor = .backgroundActionPressed
        }
        
        viewProperties.title = viewProperties.title.fontStyle(.textM)
        viewProperties.spacing = 16
        
        return viewProperties
    }
    
    private static func updateForStyleGosuslugi(
        isInversed: Bool,
        viewProperties: AuthorizationButton.ViewProperties
    ) -> AuthorizationButton.ViewProperties {
        var viewProperties = viewProperties
        
        if isInversed {
            viewProperties.backgroundColor = .backgroundMain
            viewProperties.highlightedColor = .backgroundMainPressed
        } else {
            viewProperties.backgroundColor = .backgroundInfoLight
            viewProperties.highlightedColor = .backgroundInfoLightPressed
        }
        
        viewProperties.title = viewProperties.title.fontStyle(.textM).foregroundColor(.gosuslugiButtonTitle)
        viewProperties.spacing = 8
        
        return viewProperties
    }
}
