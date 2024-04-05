//
//  InputTextareaViewStyle.swift
//
//
//  Created by Ilnur Mugaev on 05.04.2024.
//

import UIKit
import Components

public struct InputTextareaViewStyle {
    
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
        viewProperties: inout InputTextareaView.ViewProperties
    ) {
        viewProperties.header = viewProperties.header?.fontStyle(.textS).foregroundColor(.contentSecondary)
        viewProperties.text = viewProperties.text?.fontStyle(.textM).foregroundColor(state.textColor())
        viewProperties.typingText = viewProperties.typingText.fontStyle(.textM).foregroundColor(state.textColor())
        viewProperties.placeholder = viewProperties.placeholder.fontStyle(.textM).foregroundColor(.contentTertiary)
        viewProperties.backgroundColor = state.backgroundColor()
        viewProperties.border.color = state.borderColor()
        viewProperties.border = .init(color: state.borderColor(), width: 1)
        viewProperties.cornerRadius = 8
        viewProperties.isUserInteractionEnabled = state.isEnabled()
    }
}

public extension InputTextareaViewStyle.State {
    
    func textColor() -> UIColor {
        switch self {
        case .default: .contentPrimary
        case .active: .contentPrimary
        case .error: .contentPrimary
        case .disabled: .contentSecondary
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
    
    func isEnabled() -> Bool {
        switch self {
        case .default: true
        case .active: true
        case .error: true
        case .disabled: false
        }
    }
}
