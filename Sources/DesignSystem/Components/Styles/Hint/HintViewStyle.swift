import UIKit
import Components

public final class HintViewStyle {
    
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
    
    private var variant: Variant
    private var color: Color
    
    public init(
        variant: Variant,
        color: Color
    ) {
        self.variant = variant
        self.color = color
    }
    
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

        switch self.variant {
        case .both:
            let text = viewProperties.text?.string
            viewProperties.text = text?.fontStyle(.text2XS).alignment(.left).foregroundColor(textColor())
            let additionalText = viewProperties.additionalText?.string
            viewProperties.additionalText = additionalText?.fontStyle(.text2XS).alignment(.right).foregroundColor(textColor())
            viewProperties.textIsHidden = false
            viewProperties.additionalTextIsHidden = false
        case .center:
            let text = viewProperties.text?.string
            viewProperties.text = text?.fontStyle(.text2XS).alignment(.center).foregroundColor(textColor())
            viewProperties.textIsHidden = false
            viewProperties.additionalTextIsHidden = true
        case .left:
            let text = viewProperties.text?.string
            viewProperties.text = text?.fontStyle(.text2XS).alignment(.left).foregroundColor(textColor())
            viewProperties.textIsHidden = false
            viewProperties.additionalTextIsHidden = true
        case .right:
            let text = viewProperties.text?.string
            viewProperties.text = text?.fontStyle(.text2XS).alignment(.right).foregroundColor(textColor())
            viewProperties.textIsHidden = false
            viewProperties.additionalTextIsHidden = true
        case .empty:
            viewProperties.textIsHidden = true
            viewProperties.additionalTextIsHidden = true
        }
    }
}

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
