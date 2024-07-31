import UIKit
import Components
import Colors

public struct InputOTPItemViewStyle {
    
    public enum State {
        case `default`
        case active
        case error
        case disabled
    }
    
    public init() { }
    
    public func update(
        state: State,
        viewProperties: inout InputOTPItemView.ViewProperties
    ) {
        viewProperties.backgroundColor = state.backgroundColor()
        viewProperties.size = .init(width: 44, height: 56)
        viewProperties.cornerRadius = 4
        viewProperties.text = viewProperties.text
            .fontStyle(.textM)
            .foregroundColor(state.textColor())
        viewProperties.borderColor = state.borderColor()
        viewProperties.borderWidth = state.borderWidth()
    }
}

public extension InputOTPItemViewStyle.State {
    
    func textColor() -> UIColor {
        switch self {
        case .default: .Components.InputOTP.Content.Color.default
        case .active: .Components.InputOTP.Content.Color.active
        case .error: .Components.InputOTP.Content.Color.error
        case .disabled: .Components.InputOTP.Content.Color.disabled
        }
    }
    
    func backgroundColor() -> UIColor {
        switch self {
        case .default: .Components.InputOTP.Background.Color.default
        case .active: .Components.InputOTP.Background.Color.active
        case .error: .Components.InputOTP.Background.Color.error
        case .disabled: .Components.InputOTP.Background.Color.disabled
        }
    }
    
    func borderColor() -> UIColor {
        switch self {
        case .default: .Components.InputOTP.Border.Color.default
        case .active: .Components.InputOTP.Border.Color.active
        case .error: .Components.InputOTP.Border.Color.error
        case .disabled: .Components.InputOTP.Border.Color.disabled
        }
    }
    
    func borderWidth() -> CGFloat {
        switch self {
        case .default: 0
        case .active: 2
        case .error: 1
        case .disabled: 0
        }
    }
}
