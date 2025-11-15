import UIKit
import Components
import Colors

public final class InputAddCardViewStyle {
    
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
        viewProperties: inout InputAddCardView.ViewProperties
    ) {
        if let state { self.state = state }
        viewProperties.margins = .init(
            cardRowInsets: .init(top: 14, left: 16, bottom: 14, right: 16),
            spacing: 16
        )
        viewProperties.isUserInteractionEnabled = self.state.isUserInteractionEnabled()
    }
    
    func cardViewOpacity() -> CGFloat {
        switch state {
        case .default, .active, .error: 1
        case .disabled: 0.5
        }
    }
    
    func textFieldState() -> InputAddCardHintedFieldStyle.State {
        switch state {
        case .default: .default
        case .active: .active
        case .error: .error
        case .disabled: .disabled
        }
    }
    
    func buttonIconSize() -> ButtonIconStyle.Size { .small }
    
    func buttonIconState() -> ButtonIconStyle.State {
        switch state {
        case .default: .default
        case .active: .default
        case .error: .default
        case .disabled: .disabled
        }
    }
}

extension InputAddCardViewStyle.State {
    
    func isUserInteractionEnabled() -> Bool {
        switch self {
        case .disabled: false
        default: true
        }
    }
}
