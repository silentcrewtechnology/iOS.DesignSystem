//
//  TextareaViewStyle.swift
//  
//
//  Created by Ilnur Mugaev on 07.11.2023.
//

import UIKit

public enum TextareaViewStyle {
    
    public enum Style {
        case `default`
        case active
        case error
        case disabled
    }
    
    public static func restyle(
        style: Style,
        viewProperties: TextareaView.ViewProperties
    ) -> TextareaView.ViewProperties {
        var viewProperties = viewProperties
        
        viewProperties = applyFontStyle(viewProperties: viewProperties)
        
        switch style {
        case .default:
            viewProperties.header = viewProperties.header?.foregroundColor(.contentSecondary)
            viewProperties.text = viewProperties.text.foregroundColor(.contentPrimary)
            viewProperties.typingText = viewProperties.typingText.foregroundColor(.contentPrimary)
            viewProperties.placeholder = viewProperties.placeholder.foregroundColor(.contentTertiary)
            viewProperties.borderColor = .clear
            viewProperties.backgroundColor = .backgroundPrimary
        case .active:
            viewProperties.header = viewProperties.header?.foregroundColor(.contentSecondary)
            viewProperties.text = viewProperties.text.foregroundColor(.contentPrimary)
            viewProperties.typingText = viewProperties.typingText.foregroundColor(.contentPrimary)
            viewProperties.placeholder = viewProperties.placeholder.foregroundColor(.contentTertiary)
            viewProperties.counter = viewProperties.counter.foregroundColor(.contentSecondary)
            viewProperties.isCounterHidden = false
            viewProperties.borderColor = .borderAction
            viewProperties.backgroundColor = .backgroundMain
        case .error:
            viewProperties.header = viewProperties.header?.foregroundColor(.contentSecondary)
            viewProperties.text = viewProperties.text.foregroundColor(.contentPrimary)
            viewProperties.typingText = viewProperties.typingText.foregroundColor(.contentPrimary)
            viewProperties.placeholder = viewProperties.placeholder.foregroundColor(.contentTertiary)
            viewProperties.hint = viewProperties.hint.foregroundColor(.contentError)
            viewProperties.isHintHidden = false
            viewProperties.counter = viewProperties.counter.foregroundColor(.contentError)
            viewProperties.isCounterHidden = false
            viewProperties.borderColor = .borderError
            viewProperties.backgroundColor = .backgroundPrimary
        case .disabled:
            viewProperties.header = viewProperties.header?.foregroundColor(.contentSecondary)
            viewProperties.text = viewProperties.text.foregroundColor(.contentSecondary)
            viewProperties.typingText = viewProperties.typingText.foregroundColor(.contentSecondary)
            viewProperties.placeholder = viewProperties.placeholder.foregroundColor(.contentTertiary)
            viewProperties.isUserInteractionEnabled = false
            viewProperties.borderColor = .clear
            viewProperties.backgroundColor = .backgroundDisabled
        }
        
        return viewProperties
    }
    
    static func applyFontStyle(
        viewProperties: TextareaView.ViewProperties
    ) -> TextareaView.ViewProperties {
        var viewProperties = viewProperties
        viewProperties.header = viewProperties.header?.fontStyle(.textS)
        viewProperties.text = viewProperties.text.fontStyle(.textM)
        viewProperties.typingText = viewProperties.typingText.fontStyle(.textM)
        viewProperties.placeholder = viewProperties.placeholder.fontStyle(.textM)
        viewProperties.hint = viewProperties.hint.fontStyle(.text2XS).alignment(.left)
        viewProperties.counter = viewProperties.counter.fontStyle(.text2XS).alignment(.right)
        return viewProperties
    }
}
