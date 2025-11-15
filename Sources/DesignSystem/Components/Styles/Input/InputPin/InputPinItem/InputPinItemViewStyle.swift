import UIKit
import Components
import Colors

public final class InputPinItemViewStyle {
    
    public typealias Variant = InputPinItemVariables.Variant
    
    // MARK: - Private properties
    
    private var variables: InputPinItemVariables
    
    // MARK: - Init
    
    public init(
        variant: Variant = .default
    ) {
        self.variables = .init(variant: variant)
    }
    
    // MARK: - Methods
    
    public func update(
        variant: Variant? = nil,
        viewProperties: inout InputPinItemView.ViewProperties
    ) {
        if let variant { variables.variant = variant }
        
        viewProperties.backgroundColor = variables.backgroundColor()
        viewProperties.size = .init(width: 16, height: 16)
        viewProperties.cornerRadius = viewProperties.size.width / 2
    }
}

// MARK: - InputPinItemVariables

public struct InputPinItemVariables {
    
    // MARK: - Properties
    
    public enum Variant {
        case `default`
        case filled
        case success
        case error
    }
    
    public var variant: Variant
    
    // MARK: - Init
    
    public init(
        variant: Variant = .default
    ) {
        self.variant = variant
    }
    
    // MARK: - Methods
    
    public func backgroundColor() -> UIColor {
        switch variant {
        case .default: .Components.InputPINItem.Background.Color.default
        case .filled: .Components.InputPINItem.Background.Color.filled
        case .success: .Components.InputPINItem.Background.Color.success
        case .error: .Components.InputPINItem.Background.Color.error
        }
    }
}
