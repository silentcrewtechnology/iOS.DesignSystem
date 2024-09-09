import UIKit
import Components
import Colors

public final class InputPinItemViewStyle {
    
    public typealias State = InputPinItemVariables.State
    
    private var variables: InputPinItemVariables
    
    public init(
        state: State = .default
    ) {
        self.variables = .init(state: state)
    }
    
    public func update(
        state: State? = nil,
        viewProperties: inout InputPinItemView.ViewProperties
    ) {
        if let state { variables.state = state }
        viewProperties.backgroundColor = variables.backgroundColor()
        viewProperties.size = .init(width: 16, height: 16)
        viewProperties.cornerRadius = viewProperties.size.width / 2
    }
}

public struct InputPinItemVariables {
    
    public enum State {
        case `default`
        case filled
        case success
        case error
    }
    
    public var state: State
    
    public init(
        state: State = .default
    ) {
        self.state = state
    }
    
    public func backgroundColor() -> UIColor {
        switch state {
        case .default: .Components.InputPINItem.Background.Color.default
        case .filled: .Components.InputPINItem.Background.Color.filled
        case .success: .Components.InputPINItem.Background.Color.success
        case .error: .Components.InputPINItem.Background.Color.error
        }
    }
}
