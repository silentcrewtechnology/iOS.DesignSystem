//
//  SelectViewStyle.swift
//
//
//  Created by Ilnur Mugaev on 20.12.2023.
//

import UIKit
import Components

public enum SelectViewStyle {
    
    public enum Style {
        case `default`
        case active
        case error
        case disabled
    }
    
    public static func restyle(
        style: Style,
        viewProperties: SelectView.ViewProperties
    ) -> SelectView.ViewProperties {
        var viewProperties = viewProperties
        
        viewProperties = applyFontStyle(viewProperties: viewProperties)
        
        switch style {
        case .default:
            viewProperties.header = viewProperties.header?.foregroundColor(.contentSecondary)
            viewProperties.text = viewProperties.text.foregroundColor(.contentPrimary)
            viewProperties.placeholder = viewProperties.placeholder.foregroundColor(.contentTertiary)
            viewProperties.clearButtonIcon = .ic24Close.tinted(with: .contentSecondary)
            viewProperties.disclosureIcon = .ic24ChevronDown.tinted(with: .contentPrimary)
            viewProperties.isUserInteractionEnabled = true
            viewProperties.borderColor = .clear
            viewProperties.backgroundColor = .backgroundPrimary
        case .active:
            viewProperties.header = viewProperties.header?.foregroundColor(.contentSecondary)
            viewProperties.text = viewProperties.text.foregroundColor(.contentPrimary)
            viewProperties.placeholder = viewProperties.placeholder.foregroundColor(.contentTertiary)
            viewProperties.clearButtonIcon = .ic24Close.tinted(with: .contentSecondary)
            viewProperties.disclosureIcon = .ic24ChevronUp.tinted(with: .contentPrimary)
            viewProperties.isUserInteractionEnabled = true
            viewProperties.borderColor = .borderAction
            viewProperties.backgroundColor = .backgroundMain
        case .error:
            viewProperties.header = viewProperties.header?.foregroundColor(.contentSecondary)
            viewProperties.text = viewProperties.text.foregroundColor(.contentPrimary)
            viewProperties.placeholder = viewProperties.placeholder.foregroundColor(.contentTertiary)
            viewProperties.clearButtonIcon = .ic24Close.tinted(with: .contentSecondary)
            viewProperties.disclosureIcon = .ic24ChevronDown.tinted(with: .contentPrimary)
            viewProperties.hint = viewProperties.hint.foregroundColor(.contentError)
            viewProperties.isHintHidden = false
            viewProperties.isUserInteractionEnabled = true
            viewProperties.borderColor = .borderError
            viewProperties.backgroundColor = .backgroundPrimary
        case .disabled:
            viewProperties.header = viewProperties.header?.foregroundColor(.contentSecondary)
            viewProperties.text = viewProperties.text.foregroundColor(.contentSecondary)
            viewProperties.placeholder = viewProperties.placeholder.foregroundColor(.contentDisabled)
            viewProperties.clearButtonIcon = .ic24Close.tinted(with: .contentDisabled)
            viewProperties.disclosureIcon = .ic24ChevronDown.tinted(with: .contentTertiary)
            viewProperties.isUserInteractionEnabled = false
            viewProperties.borderColor = .clear
            viewProperties.backgroundColor = .backgroundDisabled
        }
        
        return viewProperties
    }
    
    static func applyFontStyle(
        viewProperties: SelectView.ViewProperties
    ) -> SelectView.ViewProperties {
        var viewProperties = viewProperties
        viewProperties.header = viewProperties.header?.fontStyle(.textS)
        viewProperties.text = viewProperties.text.fontStyle(.textM)
        viewProperties.placeholder = viewProperties.placeholder.fontStyle(.textM)
        viewProperties.hint = viewProperties.hint.fontStyle(.text2XS).alignment(.left)
        return viewProperties
    }
}
