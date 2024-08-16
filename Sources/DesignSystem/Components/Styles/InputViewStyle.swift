import UIKit
import Components
import Colors

public struct InputViewStyle {
    
    // MARK: - Properties
    
    public enum State {
        case `default`
        case active
        case error(HintView.ViewProperties)
        case disabled
    }
    
    public enum Set {
        case simple
        case icon(UIImage)
        case prefix(NSMutableAttributedString)
    }
    
    // MARK: - Private properties
    
    private let state: State
    private let set: Set
    
    // MARK: - Life cycle
    
    public init(state: State, set: Set) {
        self.state = state
        self.set = set
    }
    
    // MARK: - Public methods
    
    public func update(
        viewProperties: inout InputView.ViewProperties
    ) {
        updateTextFieldViewProperties(viewProperties: &viewProperties.textFieldViewProperties)
        
        viewProperties.textFieldBackgroundColor = state.fieldBackgroundColor()
        viewProperties.textFieldBorderColor = state.borderColor()
        viewProperties.textFieldBorderWidth = state.borderWidth()
        viewProperties.isEnabled = state.isEnabled()
        viewProperties.hintViewProperties = state.hintViewProperties()
        viewProperties.textFieldCornerRadius = 8
        viewProperties.textFieldHeight = 56
        viewProperties.minHeight = 80
        viewProperties.textFieldInsets = .init(inset: 16)
        viewProperties.stackViewInsets = .init(top: .zero, left: 16, bottom: .zero, right: 16)
        
        if var labelViewProperties = viewProperties.labelViewProperties {
            updatewLabelViewProperties(viewProperties: &labelViewProperties)
        }
        
        var rightView = UIView()
        switch set {
        case .simple:
            break
        case .icon(let image):
            rightView = UIImageView(image: image.withTintColor(state.iconColor()))
        case .prefix(let text):
            let label = UILabel()
            label.attributedText = text
                .fontStyle(.textM)
                .foregroundColor(state.prefixColor())
            rightView = label
        }
        
        viewProperties.rightView = rightView
    }
    
    // MARK: - Private methods
    
    private func updateTextFieldViewProperties(
        viewProperties: inout InputTextField.ViewProperties
    ) {
        viewProperties.text = viewProperties.text
            .fontStyle(.textM)
            .foregroundColor(state.textColor())
        viewProperties.placeholder = viewProperties.placeholder
            .fontStyle(.textM)
            .foregroundColor(state.placeholderColor())
        viewProperties.cursorColor = state.cursorColor()
    }
    
    private func updatewLabelViewProperties(
        viewProperties: inout LabelView.ViewProperties
    ) {
        viewProperties.text = viewProperties.text
            .foregroundColor(state.labelColor())
    }
}

// MARK: - InputViewStyle.State Extension

public extension InputViewStyle.State {
    func textColor() -> UIColor {
        switch self {
        case .default: .Components.Input.Content.Color.default
        case .active: .Components.Input.Content.Color.active
        case .error: .Components.Input.Content.Color.error
        case .disabled: .Components.Input.Content.Color.disabled
        }
    }
    
    func placeholderColor() -> UIColor {
        switch self {
        case .default: .Components.Input.Placeholder.Color.default
        case .active: .Components.Input.Placeholder.Color.active
        case .error: .Components.Input.Placeholder.Color.error
        case .disabled: .Components.Input.Placeholder.Color.disabled
        }
    }
    
    func labelColor() -> UIColor {
        switch self {
        case .default: .Components.Input.Label.Color.default
        case .active: .Components.Input.Label.Color.active
        case .error: .Components.Input.Label.Color.error
        case .disabled: .Components.Input.Label.Color.disabled
        }
    }
    
    func iconColor() -> UIColor {
        switch self {
        case .default: .Components.Input.Icon.Color.default
        case .active: .Components.Input.Icon.Color.active
        case .error: .Components.Input.Icon.Color.error
        case .disabled: .Components.Input.Icon.Color.disabled
        }
    }
    
    func prefixColor() -> UIColor {
        switch self {
        case .default: .Components.Input.Prefix.Color.default
        case .active: .Components.Input.Prefix.Color.active
        case .error: .Components.Input.Prefix.Color.error
        case .disabled: .Components.Input.Prefix.Color.disabled
        }
    }
    
    func fieldBackgroundColor() -> UIColor {
        switch self {
        case .default: .Components.Input.Background.Color.default
        case .active: .Components.Input.Background.Color.active
        case .error: .Components.Input.Background.Color.error
        case .disabled: .Components.Input.Background.Color.disabled
        }
    }
    
    func borderColor() -> UIColor {
        switch self {
        case .default: .Components.Input.Border.Color.default
        case .active: .Components.Input.Border.Color.active
        case .error: .Components.Input.Border.Color.error
        case .disabled: .Components.Input.Border.Color.disabled
        }
    }

    func cursorColor() -> UIColor {
        .Components.Input.Content.Color.default
    }
    
    func borderWidth() -> CGFloat {
        switch self {
        case .default, .disabled: .zero
        case .active, .error: 2
        }
    }
    
    func isEnabled() -> Bool {
        switch self {
        case .disabled: false
        default: true
        }
    }
    
    func hintViewProperties() -> HintView.ViewProperties {
        switch self {
        case .error(let viewProperties): viewProperties
        default: .init()
        }
    }
}
