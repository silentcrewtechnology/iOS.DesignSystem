import UIKit
import Components
import ImagesService

public struct CheckboxViewStyle {
    
    public typealias Selection = CheckboxVariables.Selection
    public typealias State = CheckboxVariables.State
    
    private var variables: CheckboxVariables
    public var selection: Selection {
        get { variables.selection }
        set { variables.selection = newValue }
    }
    public var state: State {
        get { variables.state }
        set { variables.state = newValue }
    }
    
    public init(
        selection: Selection,
        state: State
    ) {
        self.variables = .init(selection: selection, state: state)
    }
    
    public func update(
        viewProperties: inout CheckboxView.ViewProperties
    ) {
        viewProperties.backgroundColor = variables.backgroundColor()
        viewProperties.size = .init(width: 20, height: 20)
        viewProperties.cornerRadius = viewProperties.size.width / 2
        viewProperties.borderColor = variables.borderColor()
        viewProperties.borderWidth = variables.borderWidth()
        viewProperties.checkIcon = variables.checkIcon()
        viewProperties.isUserInteractionEnabled = state != .disabled
    }
}

public struct CheckboxVariables {
    
    public enum Selection: String {
        case `default`
        case checked
    }
    
    public enum State: String {
        case `default`
        case pressed
        case disabled
    }
    
    public var selection: Selection
    public var state: State
    
    public init(
        selection: Selection,
        state: State
    ) {
        self.selection = selection
        self.state = state
    }
    
    public func backgroundColor() -> UIColor {
        switch selection {
        case .default: backgroundDefaultColor()
        case .checked: backgroundCheckedColor()
        }
    }
    
    public func borderColor() -> UIColor {
        switch selection {
        case .default: borderDefaultColor()
        case .checked: borderCheckedColor()
        }
    }
    
    public func borderWidth() -> CGFloat {
        switch selection {
        case .checked: 0
        case .default: 1
        }
    }
    
    public func checkIcon() -> UIImage? {
        var color: UIColor
        
        switch selection {
        case .default: 
            color = backgroundDefaultColor()
        case .checked:
            color = checkIconCheckedColor()
        }
        
        return .ic10Check.withTintColor(color)
    }
    
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
