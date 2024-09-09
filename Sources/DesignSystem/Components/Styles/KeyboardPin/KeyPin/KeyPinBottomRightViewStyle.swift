import UIKit
import Components
import Colors

public final class KeyPinBottomRightViewStyle {
    
    public typealias State = KeyPinBottomRightVariables.State
    public typealias Option = KeyPinBottomRightVariables.Option
    
    private var variables: KeyPinBottomRightVariables
    
    public init(
        option: Option = .hidden,
        state: State = .default
    ) {
        self.variables = .init(
            option: option,
            state: state
        )
    }
    
    public func update(
        option: Option? = nil,
        state: State? = nil,
        viewProperties: inout KeyPinBottomRightView.ViewProperties
    ) {
        if let option { variables.option = option }
        if let state { variables.state = state }
        viewProperties.icon = variables.icon()
        viewProperties.isUserInteractionEnabled = variables.isUserInteractionEnabled()
    }
}

public struct KeyPinBottomRightVariables {
    
    public enum Option {
        case hidden
        case erase
        case touchId
        case faceId
    }
    
    public enum State: String {
        case `default`
        case pressed
    }
    
    public var option: Option
    public var state: State
    
    public init(
        option: Option,
        state: State
    ) {
        self.option = option
        self.state = state
    }
    
    public func icon() -> UIImage {
        switch option {
        case .hidden:
            return .init()
        case .erase:
            let tintColor: UIColor = switch state {
            case .default: .Semantic.LightTheme.Content.Base.tertiary
            case .pressed: .Semantic.LightTheme.Content.Base.secondary
            }
            return .ic40DeletePin.withTintColor(tintColor)
        case .touchId:
            let tintColor: UIColor = switch state {
            case .default: .Semantic.LightTheme.Content.Accent.default
            case .pressed: .Semantic.LightTheme.Content.Accent.pressed
            }
            return .ic40TouchIdPin.withTintColor(tintColor)
        case .faceId:
            let tintColor: UIColor = switch state {
            case .default: .Semantic.LightTheme.Content.Accent.default
            case .pressed: .Semantic.LightTheme.Content.Accent.pressed
            }
            return .ic40FaceIdPin.withTintColor(tintColor)
        }
    }
    
    public func isUserInteractionEnabled() -> Bool {
        option != .hidden
    }
}
