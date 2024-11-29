import UIKit
import Components
import ImagesService

public final class CheckboxViewStyle {
    
    // MARK: - Properties
    
    public typealias Selection = CheckboxVariables.Selection
    public typealias State = CheckboxVariables.State
    
    public private(set) var selection: Selection {
        get { variables.selection }
        set { variables.selection = newValue }
    }

    // MARK: - Private properties
    
    private var state: State {
        get { variables.state }
        set { variables.state = newValue }
    }
    
    private var variables: CheckboxVariables
    
    // MARK: - Init
    
    public init(
        selection: Selection,
        state: State
    ) {
        self.variables = .init(selection: selection, state: state)
    }
    
    // MARK: - Methods
    
    public func update(
        newSelection: Selection? = nil,
        newState: State? = nil,
        viewProperties: inout CheckboxView.ViewProperties
    ) {
        if let newSelection {
            selection = newSelection
        }
        
        if let newState {
            state = newState
        }
        
        viewProperties.backgroundColor = variables.backgroundColor()
        viewProperties.size = .init(width: 20, height: 20)
        viewProperties.cornerRadius = viewProperties.size.width / 2
        viewProperties.borderColor = variables.borderColor()
        viewProperties.borderWidth = variables.borderWidth()
        viewProperties.checkIcon = variables.checkIcon()
        viewProperties.isUserInteractionEnabled = state != .disabled
    }
}

// MARK: - CheckboxVariables

public struct CheckboxVariables {
    
    // MARK: - Properties
    
    public enum Selection: String {
        case off
        case on
    }
    
    public enum State: String {
        case `default`
        case pressed
        case disabled
    }
    
    public var selection: Selection
    public var state: State
    
    // MARK: - Init
    
    public init(
        selection: Selection,
        state: State
    ) {
        self.selection = selection
        self.state = state
    }
    
    // MARK: - Methods
    
    public func backgroundColor() -> UIColor {
        switch selection {
        case .off: backgroundDefaultColor()
        case .on: backgroundCheckedColor()
        }
    }
    
    public func borderColor() -> UIColor {
        switch selection {
        case .off: borderDefaultColor()
        case .on: borderCheckedColor()
        }
    }
    
    public func borderWidth() -> CGFloat {
        switch selection {
        case .on: 0
        case .off: 1
        }
    }
    
    public func checkIcon() -> UIImage? {
        var color: UIColor
        
        switch selection {
        case .off: color = backgroundDefaultColor()
        case .on: color = checkIconCheckedColor()
        }
        
        return .ic10Check.withTintColor(color)
    }
    
    // MARK: - Private methods
    
    private func backgroundDefaultColor() -> UIColor {
        switch state {
        case .default: .Components.Checkbox.Default.Background.Color.default
        case .pressed: .Components.Checkbox.Default.Background.Color.pressed
        case .disabled: .Components.Checkbox.Default.Background.Color.disabled
        }
    }
    
    private func backgroundCheckedColor() -> UIColor {
        switch state {
        case .default: .Components.Checkbox.Checked.Background.Color.default
        case .pressed: .Components.Checkbox.Checked.Background.Color.pressed
        case .disabled: .Components.Checkbox.Checked.Background.Color.disabled
        }
    }
    
    private func borderDefaultColor() -> UIColor {
        switch state {
        case .default: .Components.Checkbox.Default.Border.Color.default
        case .pressed: .Components.Checkbox.Default.Border.Color.pressed
        case .disabled: .Components.Checkbox.Default.Border.Color.disabled
        }
    }
    
    private func borderCheckedColor() -> UIColor {
        switch state {
        case .default: .Components.Checkbox.Checked.Border.Color.default
        case .pressed: .Components.Checkbox.Checked.Border.Color.pressed
        case .disabled: .Components.Checkbox.Checked.Border.Color.disabled
        }
    }
    
    private func checkIconCheckedColor() -> UIColor {
        switch state {
        case .default: .Components.Checkbox.Checked.CheckIcon.Color.default
        case .pressed: .Components.Checkbox.Checked.CheckIcon.Color.pressed
        case .disabled: .Components.Checkbox.Checked.CheckIcon.Color.disabled
        }
    }
}
