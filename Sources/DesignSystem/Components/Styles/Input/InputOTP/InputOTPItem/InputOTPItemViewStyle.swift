import UIKit
import Components
import Colors

public final class InputOTPItemViewStyle {
    
    // MARK: - Properties
    
    public enum State {
        case `default`
        case active
        case error
        case disabled
    }
    
    public private(set) var state: State
    
    // MARK: - Init
    
    public init(state: State) {
        self.state = state
    }
    
    // MARK: - Methods
    
    public func update(
        state: State? = nil,
        viewProperties: inout InputOTPItemView.ViewProperties
    ) {
        if let state { self.state = state }
        
        viewProperties.backgroundColor = self.state.backgroundColor()
        viewProperties.borderColor = self.state.borderColor()
        viewProperties.borderWidth = self.state.borderWidth()
        viewProperties.size = .init(width: 44, height: 56)
        viewProperties.cornerRadius = 4
        viewProperties.text = viewProperties.text
            .fontStyle(.textM)
            .foregroundColor(self.state.textColor())
            .alignment(.center)
    }
}

// MARK: - InputOTPItemViewStyle.State Extension

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
        case .default, .disabled: 0
        case .active: 2
        case .error: 1
        }
    }
}
