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
        viewProperties.offTintColor = .backgroundTertiary
        viewProperties.onTintColor = .contentActionHover
        viewProperties.isEnabled = state == .default
    }
}
