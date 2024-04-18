//
//  InputPhoneNumberViewStyle.swift
//
//
//  Created by Ilnur Mugaev on 12.04.2024.
//

import UIKit
import Components

public struct InputPhoneNumberViewStyle {
    
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
        viewProperties: inout InputPhoneNumberView.ViewProperties
    ) {
        viewProperties.text = viewProperties.text?.fontStyle(.textM).foregroundColor(state.textColor())
        viewProperties.defaultText = viewProperties.defaultText.fontStyle(.textM).foregroundColor(state.textColor())
        viewProperties.placeholder = viewProperties.placeholder?.fontStyle(.textM).foregroundColor(.contentTertiary)
        viewProperties.clearButtonIcon = .ic24Close.withTintColor(state.imageTintColor())
        viewProperties.backgroundColor = state.backgroundColor()
        viewProperties.border = .init(color: state.borderColor(), width: 1, cornerRadius: 8)
        viewProperties.isUserInteractionEnabled = state.isEnabled()
        updatePrefix(viewProperties: &viewProperties)
    }
    
    private func updatePrefix(
        viewProperties: inout InputPhoneNumberView.ViewProperties
    ) {
        switch viewProperties.prefix {
        case let .icon(image):
            viewProperties.prefix = .icon(
                image: image.withTintColor(state.imageTintColor())
            )
        case let .country(flag, code):
            viewProperties.prefix = .country(
                flag: flag,
                code: code.fontStyle(.textM).foregroundColor(state.textColor())
            )
        }
    }
}

public extension InputPhoneNumberViewStyle.State {
    
    func imageTintColor() -> UIColor {
        switch self {
        case .default: .contentSecondary
        case .active: .contentSecondary
        case .error: .contentSecondary
        case .disabled: .contentDisabled
        }
    }
    
    func textColor() -> UIColor {
        switch self {
        case .default: .contentPrimary
        case .active: .contentPrimary
        case .error: .contentPrimary
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
    
    func isEnabled() -> Bool {
        switch self {
        case .default: true
        case .active: true
        case .error: true
        case .disabled: false
        }
    }
}
