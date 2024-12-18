import UIKit
import Components
import Colors

public final class ToggleViewStyle {
    
    // MARK: - Properties
    
    public enum State {
        case `default`
        case disabled
    }
    
    public enum Checked {
        case off
        case on
    }
    
    // MARK: - Private properties
    
    private var state: State
    private var checked: Checked
    
    // MARK: - Init
    
    public init(
        state: State,
        checked: Checked = .off
    ) {
        self.state = state
        self.checked = checked
    }
    
    // MARK: - Public methods
        
    public func update(
        newState: State? = nil,
        newChecked: Checked? = nil,
        viewProperties: inout ToggleView.ViewProperties
    ) {
        if let newState {
            state = newState
        }
        
        if let newChecked {
            checked = newChecked
        }
        
        viewProperties.offTintColor = state.offTintColor()
        viewProperties.onTintColor = state.onTintColor()
        viewProperties.thumbColor = thumbTintColor()
        viewProperties.isEnabled = state != .disabled
        viewProperties.isChecked = checked == .on
    }
    
    // MARK: - Private methods
    
    private func thumbTintColor() -> UIColor {
        switch checked {
        case .off: state.thumbOffTintColor()
        case .on: state.thumbOnTintColor()
        }
    }
}

// MARK: - ToggleViewStyle.State Extension

public extension ToggleViewStyle.State {
    
    func offTintColor() -> UIColor {
        switch self {
        case .default: .Components.Toggle.Default.Background.Color.default
        case .disabled: .Components.Toggle.Default.Background.Color.disabled
        }
    }
    
    func onTintColor() -> UIColor {
        switch self {
        case .default: .Components.Toggle.Checked.Background.Color.default
        case .disabled: .Components.Toggle.Checked.Background.Color.disabled
        }
    }
    
    func thumbOffTintColor() -> UIColor {
        switch self {
        case .default: .Components.Toggle.Default.Switch.Color.default
        case .disabled: .Components.Toggle.Default.Switch.Color.disabled
        }
    }
    
    func thumbOnTintColor() -> UIColor {
        switch self {
        case .default: .Components.Toggle.Checked.Switch.Color.default
        case .disabled: .Components.Toggle.Checked.Switch.Color.disabled
        }
    }
}
