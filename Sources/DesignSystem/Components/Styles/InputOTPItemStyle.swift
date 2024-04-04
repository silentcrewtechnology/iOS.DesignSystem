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
            .foregroundColor(.contentPrimary)
        viewProperties.borderColor = state.borderColor()
        viewProperties.borderWidth = state.borderWidth()
    }
}

public extension InputOTPItemViewStyle.State {
    
    func backgroundColor() -> UIColor {
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
        case .active: 2
        case .error: 1
        case .disabled: 0
        }
    }
}
