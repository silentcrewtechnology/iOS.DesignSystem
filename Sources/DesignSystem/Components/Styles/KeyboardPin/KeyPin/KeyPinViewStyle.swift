import UIKit
import Components
import Colors

public final class KeyPinViewStyle {
    
    public typealias State = KeyPinVariables.State
    
    private var variables: KeyPinVariables
    
    public init(
        state: State = .default
    ) {
        self.variables = .init(state: state)
    }
    
    public func update(
        state: State? = nil,
        viewProperties: inout KeyPinView.ViewProperties
    ) {
        if let state { variables.state = state }
        viewProperties.backgroundColor = variables.backgroundColor()
        viewProperties.size = .init(width: 72, height: 72)
        viewProperties.cornerRadius = viewProperties.size.width / 2 // circle
        viewProperties.borderColor = variables.borderColor()
        viewProperties.borderWidth = variables.borderWidth()
        viewProperties.digit = viewProperties.digit
            .fontStyle(variables.fontStyle())
            .foregroundColor(variables.textColor())
    }
}

public struct KeyPinVariables {
    
    public enum State: String {
        case `default`
        case pressed
    }
    
    public var state: State
    
    public init(
        state: State
    ) {
        self.state = state
    }
    
    public func backgroundColor() -> UIColor {
        switch state {
        case .default: .Semantic.LightTheme.Background.Base.main
        case .pressed: .Semantic.LightTheme.Background.Base.mainPressed
        }
    }
    
    public func borderColor() -> UIColor {
        .Semantic.LightTheme.Border.Base.secondary
    }
    
    public func borderWidth() -> CGFloat {
        1
    }
    
    public func fontStyle() -> FontStyle {
        .text3XL
    }
    
    public func textColor() -> UIColor {
        .Semantic.LightTheme.Content.Base.primary
    }
}
