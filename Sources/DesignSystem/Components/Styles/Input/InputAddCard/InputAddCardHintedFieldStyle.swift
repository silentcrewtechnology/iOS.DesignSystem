import UIKit
import Components
import Colors

public final class InputAddCardHintedFieldStyle {
    
    public enum State {
        case `default`
        case active
        case error
        case disabled
    }
    
    public private(set) var state: State
    
    public init(
        state: State = .default
    ) {
        self.state = state
    }
    
    public func update(
        state: State? = nil,
        viewProperties: inout InputAddCardHintedField.ViewProperties
    ) {
        if let state { self.state = state }
        viewProperties.hint = viewProperties.hint.string.attributed
            .fontStyle(.textXS)
            .foregroundColor(self.state.hintColor())
            .alignment(.left)
        updateTextField(viewProperties: &viewProperties.textFieldViewProperties)
    }
    
    private func updateTextField(viewProperties: inout InputTextField.ViewProperties) {
        viewProperties.textAttributes = [
            .font: UIFont.textM,
            .foregroundColor: state.contentColor(),
        ]
        viewProperties.placeholder = viewProperties.placeholder.string.attributed
            .fontStyle(.textM)
            .foregroundColor(state.placeholderColor())
            .alignment(.left)
        viewProperties.cursorColor = state.cursorColor()
        viewProperties.keyboardType = .numberPad
    }
}

private extension InputAddCardHintedFieldStyle.State {
    
    func contentColor() -> UIColor {
        switch self {
        case .default: .Components.InputAddCard.Content.Color.default
        case .active: .Components.InputAddCard.Content.Color.active
        case .error: .Components.InputAddCard.Content.Color.error
        case .disabled: .Components.InputAddCard.Content.Color.disabled
        }
    }
    
    func placeholderColor() -> UIColor {
        switch self {
        case .default: .Components.InputAddCard.Placeholder.Color.default
        case .active: .Components.InputAddCard.Placeholder.Color.active
        case .error: .Components.InputAddCard.Placeholder.Color.error
        case .disabled: .Components.InputAddCard.Placeholder.Color.disabled
        }
    }
    
    func cursorColor() -> UIColor { .Components.InputAddCard.Content.Color.default }
    
    func hintColor() -> UIColor {
        switch self {
        case .default: .Components.InputAddCard.Hint.Color.default
        case .active: .Components.InputAddCard.Hint.Color.active
        case .error: .Components.InputAddCard.Hint.Color.error
        case .disabled: .Components.InputAddCard.Hint.Color.disabled
        }
    }
}
