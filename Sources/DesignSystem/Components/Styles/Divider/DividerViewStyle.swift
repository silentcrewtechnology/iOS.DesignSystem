import UIKit
import Components
import Colors

public final class DividerViewStyle {
    
    public typealias ViewProperties = DividerView.ViewProperties
    
    public enum Variant {
        case horizontal
        case vertical
        case fixed(CGSize)
    }
    
    public enum Style {
        case accent
        case main
        case secondary
    }
    
    private var variant: Variant
    private var style: Style
    
    public init(
        variant: Variant,
        style: Style
    ) {
        self.style = style
        self.variant = variant
    }
    
    public func update(
        variant: Variant? = nil,
        style: Style? = nil,
        viewProperties: inout ViewProperties
    ) {
        if let variant {
            self.variant = variant
        }
        
        if let style {
            self.style = style
        }
        
        updateVariant(variant: self.variant, viewProperties: &viewProperties)
        updateStyle(style: self.style, viewProperties: &viewProperties)
    }
    
    private func updateVariant(
        variant: Variant,
        viewProperties: inout ViewProperties
    ) {
        switch variant {
        case .horizontal:
            viewProperties.size = .height(Constant.thickness)
        case .vertical:
            viewProperties.size = .width(Constant.thickness)
        case .fixed(let size):
            viewProperties.size = .size(size)
        }
    }
    
    private func updateStyle(
        style: Style,
        viewProperties: inout ViewProperties
    ) {
        switch style {
        case .accent: viewProperties.backgroundColor = .Components.Divider.Accent.Color.color
        case .main: viewProperties.backgroundColor = .Components.Divider.Main.Color.color
        case .secondary: viewProperties.backgroundColor = .Components.Divider.Secondary.Color.color
        }
    }
}

private enum Constant {
    static let thickness: CGFloat = 1
}
