import UIKit
import Components
import Colors

public final class InputSelectViewStyle {
    
    // MARK: - Properties
    
    public enum State {
        case `default`
        case active
        case error
        case disabled
    }
    
    public enum Label {
        case off
        case on
    }
    
    public private(set) var state: State
    public private(set) var label: Label
    
    // MARK: - Life cycle
    
    public init(
        state: State,
        label: Label = .off
    ) {
        self.state = state
        self.label = label
    }
    
    // MARK: - Public methods
    
    public func update(
        newState: State? = nil,
        newLabel: Label? = nil,
        viewProperties: inout InputSelectView.ViewProperties
    ) {
        if let newState { state = newState }
        
        if let newLabel { label = newLabel }
        
        updateTextFieldViewProperties(viewProperties: &viewProperties.textFieldViewProperties)
        
        viewProperties.inputBackgroundColor = state.backgroundColor()
        viewProperties.inputBorderColor = state.borderColor()
        viewProperties.inputBorderWidth = state.borderWidth()
        viewProperties.inputCornerRadius = 8
        viewProperties.inputStackViewSpacing = 8
        viewProperties.inputHeight = 56
        viewProperties.inputInsets = .init(inset: 16)
        viewProperties.rightViewsSize = .init(width: 24, height: 24)
        viewProperties.isEnabled = state.isEnabled()
        viewProperties.verticalStackViewInsets = .init(top: .zero, left: 16, bottom: .zero, right: 16)
        viewProperties.clearButtonIcon = .ic24Close.withTintColor(state.iconColor())
        viewProperties.disclosureButtonIcon = state.disclosureButtonIcon()
    }
    
    // MARK: - Private methods
    
    private func updateTextFieldViewProperties(
        viewProperties: inout InputTextField.ViewProperties
    ) {
        viewProperties.textAttributes = [
            .font: UIFont.textM,
            .foregroundColor: state.textColor(),
        ]
        viewProperties.placeholder = viewProperties.placeholder
            .fontStyle(.textM)
            .foregroundColor(state.placeholderColor())
            .alignment(.left)
        viewProperties.cursorColor = state.cursorColor()
    }
}

// MARK: - InputViewStyle.State Extension

public extension InputSelectViewStyle.State {
    
    func textColor() -> UIColor {
        switch self {
        case .default: .Components.InputSelect.Content.Color.default
        case .active: .Components.InputSelect.Content.Color.active
        case .error: .Components.InputSelect.Content.Color.error
        case .disabled: .Components.InputSelect.Content.Color.disabled
        }
    }
    
    func placeholderColor() -> UIColor {
        switch self {
        case .default: .Components.InputSelect.Placeholder.Color.default
        case .active: .Components.InputSelect.Placeholder.Color.active
        case .error: .Components.InputSelect.Placeholder.Color.error
        case .disabled: .Components.InputSelect.Placeholder.Color.disabled
        }
    }
    
    func iconColor() -> UIColor {
        switch self {
        case .default: .Components.InputSelect.Icon.Color.default
        case .active: .Components.InputSelect.Icon.Color.active
        case .error: .Components.InputSelect.Icon.Color.error
        case .disabled: .Components.InputSelect.Icon.Color.disabled
        }
    }
    
    func backgroundColor() -> UIColor {
        switch self {
        case .default: .Components.InputSelect.Background.Color.default
        case .active: .Components.InputSelect.Background.Color.active
        case .error: .Components.InputSelect.Background.Color.error
        case .disabled: .Components.InputSelect.Background.Color.disabled
        }
    }
    
    func borderColor() -> UIColor {
        switch self {
        case .default: .Components.InputSelect.Border.Color.default
        case .active: .Components.InputSelect.Border.Color.active
        case .error: .Components.InputSelect.Border.Color.error
        case .disabled: .Components.InputSelect.Border.Color.disabled
        }
    }

    func cursorColor() -> UIColor {
        .Components.InputSelect.Content.Color.default
    }
    
    func borderWidth() -> CGFloat {
        switch self {
        case .active: 2
        case .error: 1
        default: .zero
        }
    }
    
    func isEnabled() -> Bool {
        switch self {
        case .disabled: false
        default: true
        }
    }
    
    func disclosureButtonIcon() -> UIImage {
        let icon: UIImage = self == .active
            ? .ic24ChevronUp
            : .ic24ChevronDown
        return icon.withTintColor(iconColor())
    }
}
