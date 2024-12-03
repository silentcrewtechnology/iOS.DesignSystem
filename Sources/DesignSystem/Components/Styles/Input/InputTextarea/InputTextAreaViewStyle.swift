import UIKit
import Components

public final class InputTextAreaViewStyle {
    
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
    
    // MARK: - Init
    
    public init(
        state: State,
        label: Label = .off
    ) {
        self.state = state
        self.label = label
    }
    
    // MARK: - Methods
    
    public func update(
        newState: State? = nil,
        newLabel: Label? = nil,
        viewProperties: inout InputTextAreaView.ViewProperties
    ) {
        if let newState {
            state = newState
        }
        
        if let newLabel {
            label = newLabel
        }
        
        viewProperties.backgroundColor = state.backgroundColor()
        viewProperties.border = .init(color: state.borderColor(), width: 2)
        viewProperties.minTextViewHeight = 56
        viewProperties.cornerRadius = 8
        viewProperties.isUserInteractionEnabled = self.state != .disabled
        viewProperties.stackViewInsets = .init(top: .zero, left: 16, bottom: .zero, right: 16)
        viewProperties.placeholderInsets = .init(inset: 16)
        viewProperties.textViewInsets = .init(inset: 16)
        
        viewProperties.placeholder = viewProperties.placeholder
            .fontStyle(.textM)
            .foregroundColor(state.placeholderColor())
            .alignment(.left)
        viewProperties.textViewProperties.text = viewProperties.textViewProperties.text
            .fontStyle(.textM)
            .foregroundColor(state.textColor())
            .alignment(.left)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 24
        viewProperties.textViewProperties.textAttributes = [
            .font: UIFont.textM,
            .foregroundColor: state.textColor(),
            .paragraphStyle: paragraphStyle
        ]
    }
}

// MARK: - InputTextareaViewStyle.State Extension

public extension InputTextAreaViewStyle.State {

    func textColor() -> UIColor {
        switch self {
        case .default: .Components.InputTextArea.Content.Color.default
        case .active: .Components.InputTextArea.Content.Color.active
        case .error: .Components.InputTextArea.Content.Color.error
        case .disabled: .Components.InputTextArea.Content.Color.disabled
        }
    }
    
    func placeholderColor() -> UIColor {
        switch self {
        case .default: .Components.InputTextArea.Placeholder.Color.default
        case .active: .Components.InputTextArea.Placeholder.Color.active
        case .error: .Components.InputTextArea.Placeholder.Color.error
        case .disabled: .Components.InputTextArea.Placeholder.Color.disabled
        }
    }
    
    func borderColor() -> UIColor {
        switch self {
        case .default: .Components.InputTextArea.Border.Color.default
        case .active: .Components.InputTextArea.Border.Color.active
        case .error: .Components.InputTextArea.Border.Color.error
        case .disabled: .Components.InputTextArea.Border.Color.disabled
        }
    }
    
    func backgroundColor() -> UIColor {
        switch self {
        case .default: .Components.InputTextArea.Background.Color.default
        case .active: .Components.InputTextArea.Background.Color.active
        case .error: .Components.InputTextArea.Background.Color.error
        case .disabled: .Components.InputTextArea.Background.Color.disabled
        }
    }
}
