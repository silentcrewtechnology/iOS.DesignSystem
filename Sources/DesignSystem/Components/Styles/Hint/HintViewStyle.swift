import UIKit
import Components

public final class HintViewStyle {
    
    // MARK: - Properties
    
    public enum Variant {
        case both
        case center
        case left
        case right
        case empty
    }
    
    public enum Color {
        case `default`
        case active
        case error
        case disabled
    }
    
    // MARK: - Private properties
    
    private var variant: Variant
    private var color: Color
    
    // MARK: - Init
    
    public init(
        variant: Variant,
        color: Color
    ) {
        self.variant = variant
        self.color = color
    }
    
    // MARK: - Methods
    
    public func update(
        variant: Variant? = nil,
        color: Color? = nil,
        viewProperties: inout HintView.ViewProperties
    ) {
        if let variant {
            self.variant = variant
        }
        
        if let color {
            self.color = color
        }
        
        var textAlignment: NSTextAlignment = .left
        switch self.variant {
        case .both:
            viewProperties.textIsHidden = false
            viewProperties.additionalTextIsHidden = false
        case .center:
            textAlignment = .center
            viewProperties.textIsHidden = false
            viewProperties.additionalTextIsHidden = true
        case .left:
            viewProperties.textIsHidden = false
            viewProperties.additionalTextIsHidden = true
        case .right:
            viewProperties.textIsHidden = true
            viewProperties.additionalTextIsHidden = false
        case .empty:
            viewProperties.textIsHidden = true
            viewProperties.additionalTextIsHidden = true
        }
        
        viewProperties.text = viewProperties.text?
            .fontStyle(.text2XS)
            .alignment(textAlignment)
            .foregroundColor(textColor())
        viewProperties.additionalText = viewProperties.additionalText?
            .fontStyle(.text2XS)
            .alignment(.right)
            .foregroundColor(textColor())
    }
}

// MARK: - HintViewStyle Extension

extension HintViewStyle {
    
   private func textColor() -> UIColor {
        switch color {
        case .default: .Components.Hint.Color.default
        case .active: .Components.Hint.Color.active
        case .error: .Components.Hint.Color.error
        case .disabled: .Components.Hint.Color.disabled
        }
    }
}
