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
        viewProperties.header = viewProperties.header?
            .fontStyle(.textS)
            .foregroundColor(.contentSecondary)
        
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
        viewProperties.clearButtonIcon = state.clearButtonIcon()
        viewProperties.disclosureIcon = state.disclosureIcon()
        viewProperties.isUserInteractionEnabled = state.isEnabled()
    }
}

public extension InputSelectViewStyle.State {
    
    func textColor() -> UIColor {
        switch self {
        case .default: .contentPrimary
        case .active: .contentPrimary
        case .error: .contentPrimary
        case .disabled: .contentSecondary
        }
    }
    
    func placeholderColor() -> UIColor {
        switch self {
        case .default: .contentTertiary
        case .active: .contentTertiary
        case .error: .contentTertiary
        case .disabled: .contentDisabled
        }
    }
    
    func borderColor() -> UIColor {
        switch self {
        case .default: .clear
        case .active: .borderAction
        case .error: .borderError
        case .disabled: .clear
        }
    }
    
    func backgroundColor() -> UIColor {
        switch self {
        case .default: .backgroundPrimary
        case .active: .backgroundMain
        case .error: .backgroundPrimary
        case .disabled: .backgroundDisabled
        }
    }
    
    func clearButtonIcon() -> UIImage {
        switch self {
        case .default: .ic24Close.tinted(with: .contentSecondary)
        case .active: .ic24Close.tinted(with: .contentSecondary)
        case .error: .ic24Close.tinted(with: .contentSecondary)
        case .disabled: .ic24Close.tinted(with: .contentDisabled)
        }
    }
    
    func disclosureIcon() -> UIImage {
        switch self {
        case .default: .ic24ChevronDown.tinted(with: .contentPrimary)
        case .active: .ic24ChevronUp.tinted(with: .contentPrimary)
        case .error: .ic24ChevronDown.tinted(with: .contentPrimary)
        case .disabled: .ic24ChevronDown.tinted(with: .contentTertiary)
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
