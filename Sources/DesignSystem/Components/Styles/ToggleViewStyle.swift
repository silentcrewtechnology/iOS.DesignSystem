//
//  ToggleViewStyle.swift
//  
//
//  Created by user on 13.05.2024.
//

import UIKit
import Components
import Colors

public struct ToggleViewStyle {
    
    // MARK: - Properties
    
    public enum State {
        case `default`
        case pressed
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
        viewProperties.offTintColor = state.offTintColor()
        viewProperties.onTintColor = state.onTintColor()
        viewProperties.thumbOffTintColor = state.thumbOffTintColor()
        viewProperties.thumbOnTintColor = state.thumbOnTintColor()
        viewProperties.isEnabled = state == .default
    }
}

// MARK: - ToggleViewStyle.State Extension

public extension ToggleViewStyle.State {
    func offTintColor() -> UIColor {
        switch self {
        case .default: .Components.Toggle.Default.Background.Color.default
        case .pressed: .Components.Toggle.Default.Background.Color.pressed
        case .disabled: .Components.Toggle.Default.Background.Color.disabled
        }
    }
    
    func onTintColor() -> UIColor {
        switch self {
        case .default: .Components.Toggle.Checked.Background.Color.default
        case .pressed: .Components.Toggle.Checked.Background.Color.pressed
        case .disabled: .Components.Toggle.Checked.Background.Color.disabled
        }
    }
    
    func thumbOffTintColor() -> UIColor {
        switch self {
        case .default: .Components.Toggle.Default.Switch.Color.default
        case .pressed: .Components.Toggle.Default.Switch.Color.pressed
        case .disabled: .Components.Toggle.Default.Switch.Color.disabled
        }
    }
    
    func thumbOnTintColor() -> UIColor {
        switch self {
        case .default: .Components.Toggle.Checked.Switch.Color.default
        case .pressed: .Components.Toggle.Checked.Switch.Color.pressed
        case .disabled: .Components.Toggle.Checked.Switch.Color.disabled
        }
    }
}
