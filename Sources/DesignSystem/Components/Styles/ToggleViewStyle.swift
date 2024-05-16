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
    
    public var state: State
    
    public init(state: State) {
        self.state = state
    }
    
    // MARK: - Public methods
        
    public func update(
        viewProperties: inout ToggleView.ViewProperties
    ) {
        viewProperties.offTintColor = .backgroundTertiary
        viewProperties.onTintColor = .contentActionHover
        viewProperties.isEnabled = state == .default
    }
}
