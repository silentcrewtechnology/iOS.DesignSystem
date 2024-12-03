import UIKit
import Components
import Colors

public final class InputViewStyle {
    
    // MARK: - Properties
    
    public enum State {
        case `default`
        case active
        case error
        case disabled
    }
    
    public enum Set {
        case simple
        case icon(UIImage)
        case prefix(NSMutableAttributedString)
    }
    
    public enum Label {
        case off
        case on
    }
    
    public private(set) var state: State
    public private(set) var label: Label
    
    // MARK: - Private properties

    private var set: Set
    
    // MARK: - Life cycle
    
    public init(
        state: State,
        set: Set,
        label: Label = .off
    ) {
        self.state = state
        self.set = set
        self.label = label
    }
    
    // MARK: - Public methods
    
    public func update(
        state: State? = nil,
        set: Set? = nil,
        label: Label? = nil,
        viewProperties: inout InputView.ViewProperties
    ) {
        if let state {
            self.state = state
        }
        
        if let set {
            self.set = set
        }
        
        if let label {
            self.label = label
        }
        
        updateTextFieldViewProperties(viewProperties: &viewProperties.textFieldViewProperties)
        
        viewProperties.textFieldBackgroundColor = self.state.fieldBackgroundColor()
        viewProperties.textFieldBorderColor = self.state.borderColor()
        viewProperties.textFieldBorderWidth = self.state.borderWidth()
        viewProperties.isEnabled = self.state.isEnabled()
        viewProperties.textFieldCornerRadius = 8
        viewProperties.textFieldHeight = 56
        viewProperties.textFieldInsets = .init(inset: 16)
        viewProperties.stackViewInsets = .init(top: .zero, left: 16, bottom: .zero, right: 16)
        
        var rightView = UIView()
        switch self.set {
        case .simple:
            break
        case .icon(let image):
            rightView = UIImageView(image: image.withTintColor(self.state.iconColor()))
        case .prefix(let text):
            let label = UILabel()
            label.attributedText = text
                .fontStyle(.textM)
                .foregroundColor(self.state.prefixColor())
            rightView = label
        }
        
        viewProperties.rightView = rightView
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
}
