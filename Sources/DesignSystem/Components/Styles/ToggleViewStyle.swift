//
//  ToggleViewStyle.swift
//  
//
//  Created by user on 13.05.2024.
//

import Components

public struct ToggleViewStyle {
    
    // MARK: - Properties
    
    public enum Variant {
        case `default`
        case disabled
    }
    
    // MARK: - Public methods
        
    public func update(
        variant: Variant,
        viewProperties: inout ToggleView.ViewProperties
    ) {
        switch variant {
        case .default:
            viewProperties.isEnabled = true
            viewProperties.offTintColor = .backgroundTertiary
            viewProperties.onTintColor = .contentActionHover
        case .disabled:
            viewProperties.isEnabled = false
            viewProperties.offTintColor = .backgroundTertiary
            viewProperties.onTintColor = .contentActionHover
        }
    }
}
