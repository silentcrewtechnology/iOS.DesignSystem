//
//  ToggleViewStyle.swift
//  
//
//  Created by user on 13.05.2024.
//

import Components

public struct ToggleViewStyle {
    
    // MARK: - Properties
    
    public enum State {
        case `default`
        case disabled
    }
    
    // MARK: - Public methods
        
    public func update(
        state: State,
        viewProperties: inout ToggleView.ViewProperties
    ) {
        switch state {
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
