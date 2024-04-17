import UIKit
import Components
import Colors

public struct InputTextViewStyle {
    
    public enum State {
        case `default`
        case active
        case error(NSMutableAttributedString)
        case disabled
    }
    
    private let hintStyle = HintViewStyle()
    
    public init() { }
    
    public func update(
        state: State,
        viewProperties: inout InputTextView.ViewProperties
    ) {
        updateField(state: state, viewProperties: &viewProperties.textField)
        updateFieldContainer(state: state, viewProperties: &viewProperties)
        hintStyle.update(variant: state.hintVariant(), viewProperties: &viewProperties.hint)
    }
    
    public func updateField(
        state: State,
        viewProperties: inout InputTextField.ViewProperties
    ) {
        viewProperties.text = viewProperties.text
            .fontStyle(.textM)
            .foregroundColor(state.textColor())
        viewProperties.placeholder = viewProperties.placeholder
            .fontStyle(.textM)
            .foregroundColor(.contentTertiary)
        viewProperties.cursorColor = state.tintColor()
    }
    
    public func updateFieldContainer(
        state: State,
        viewProperties: inout InputTextView.ViewProperties
    ) {
        viewProperties.fieldBackgroundColor = state.fieldBackgroundColor()
        viewProperties.borderColor = state.borderColor()
        viewProperties.borderWidth = state.borderWidth()
        viewProperties.cornerRadius = 8
        viewProperties.isEnabled = state.isEnabled()
        tintRightImages(state: state, viewProperties: &viewProperties)
    }
    
    public func tintRightImages(
        state: State,
        viewProperties: inout InputTextView.ViewProperties
    ) {
        for view in viewProperties.rightViews {
            guard let view = view as? UIImageView else { continue }
            view.image = view.image?.tinted(with: state.tintColor())
        }
    }
}

public extension InputTextViewStyle.State {
    
    func textColor() -> UIColor {
        switch self {
        case .default: .contentPrimary
        case .active: .contentPrimary
        case .error: .contentPrimary
        case .disabled: .contentDisabled
        }
    }
    
    func fieldBackgroundColor() -> UIColor {
        switch self {
        case .default: .backgroundPrimary
        case .active: .backgroundMain
        case .error: .backgroundPrimary
        case .disabled: .backgroundDisabled
        }
    }
    
    func borderColor() -> UIColor {
        switch self {
        case .default: .clear
        case .active: .borderAction
        case .error: .borderError
        case .disabled: .clear
        }
    }
    
    func borderWidth() -> CGFloat {
        switch self {
        case .default: 0
        case .active: 1
        case .error: 1
        case .disabled: 1
        }
    }
    
    func tintColor() -> UIColor {
        switch self {
        case .default: .contentSecondary
        case .active: .contentSecondary
        case .error: .contentSecondary
        case .disabled: .contentDisabled
        }
    }
    
    func isEnabled() -> Bool {
        switch self {
        case .disabled: false
        default: true
        }
    }
    
    func hintVariant() -> HintViewStyle.Variant {
        switch self {
        case .default: .empty
        case .active: .empty
        case .error(let error): .left(error.foregroundColor(.contentError))
        case .disabled: .empty
        }
    }
}
