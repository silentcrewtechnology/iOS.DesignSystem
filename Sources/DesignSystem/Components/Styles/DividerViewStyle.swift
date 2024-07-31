import UIKit
import Components
import Colors

public struct DividerViewStyle {
    
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
    
    private let variant: Variant
    private let style: Style
    
    public init(
        variant: Variant,
        style: Style
    ) {
        self.style = style
        self.variant = variant
    }
    
    public func update(
        viewProperties: inout ViewProperties
    ) {
        update(variant: variant, viewProperties: &viewProperties)
        update(style: style, viewProperties: &viewProperties)
    }
    
    private func update(
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
    
    private func update(
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
