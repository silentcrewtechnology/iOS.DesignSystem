//
//  InputSelectViewStyle.swift
//
//
//  Created by Ilnur Mugaev on 16.04.2024.
//

import UIKit
import Components

public struct InputSelectViewStyle {
    
    public enum State {
        case `default`
        case active
        case error
        case disabled
    }
    
    private let state: State
    
    public init(state: State) {
        self.state = state
    }
    
    public func update(
        viewProperties: inout InputSelectView.ViewProperties
    ) {
        viewProperties.text = viewProperties.text
            .fontStyle(.textM)
            .foregroundColor(state.textColor())
        
        viewProperties.placeholder = viewProperties.placeholder
            .fontStyle(.textM)
            .foregroundColor(state.placeholderColor())
        
        viewProperties.border = .init(
            color: state.borderColor(),
            width: 1,
            cornerRadius: 8
        )
        
        viewProperties.backgroundColor = state.backgroundColor()
        viewProperties.clearButtonIcon = .ic24Close.withTintColor(state.iconColor())
        viewProperties.disclosureIcon = .ic24ChevronDown.withTintColor(state.iconColor())
        viewProperties.isUserInteractionEnabled = state.isEnabled()
    }
}

public extension InputSelectViewStyle.State {
    
    func textColor() -> UIColor {
        switch self {
        case .default: .Components.InputSelect.Content.Color.default
        case .active: .Components.InputSelect.Content.Color.active
        case .error: .Components.InputSelect.Content.Color.error
        case .disabled: .Components.InputSelect.Content.Color.disabled
        }
    }
    
    func placeholderColor() -> UIColor {
        switch self {
        case .default: .Components.InputSelect.Placeholder.Color.default
        case .active: .Components.InputSelect.Placeholder.Color.active
        case .error: .Components.InputSelect.Placeholder.Color.error
        case .disabled: .Components.InputSelect.Placeholder.Color.disabled
        }
    }
    
    func borderColor() -> UIColor {
        switch self {
        case .default: .Components.InputSelect.Border.Color.default
        case .active: .Components.InputSelect.Border.Color.active
        case .error: .Components.InputSelect.Border.Color.error
        case .disabled: .Components.InputSelect.Border.Color.disabled
        }
    }
    
    func backgroundColor() -> UIColor {
        switch self {
        case .default: .Components.InputSelect.Background.Color.default
        case .active: .Components.InputSelect.Background.Color.active
        case .error: .Components.InputSelect.Background.Color.error
        case .disabled: .Components.InputSelect.Background.Color.disabled
        }
    }
    
    func iconColor() -> UIColor {
        switch self {
        case .default: .Components.InputSelect.Icon.Color.default
        case .active: .Components.InputSelect.Icon.Color.active
        case .error: .Components.InputSelect.Icon.Color.error
        case .disabled: .Components.InputSelect.Icon.Color.disabled
        }
    }

    func isEnabled() -> Bool {
        switch self {
        case .default: true
        case .active: true
        case .error: true
        case .disabled: false
        }
    }
}
