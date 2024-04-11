import UIKit
import Components
import Colors

public struct DividerViewStyle {
    
    public typealias ViewProperties = DividerView.ViewProperties
    
    public enum Orientation {
        case horizontal
        case vertical
        case fixed(CGSize)
    }
    
    public enum Style {
        case action
        case main
        case secondary
    }
    
    private let orientation: Orientation
    private let style: Style
    
    public init(
        orientation: Orientation,
        style: Style
    ) {
        self.style = style
        self.orientation = orientation
    }
    
    public func update(
        viewProperties: inout ViewProperties
    ) {
        update(orientation: orientation, viewProperties: &viewProperties)
        update(style: style, viewProperties: &viewProperties)
    }
    
    private func update(
        orientation: Orientation,
        viewProperties: inout ViewProperties
    ) {
        switch orientation {
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
        case .action:
            viewProperties.backgroundColor = .borderAction
        case .main:
            viewProperties.backgroundColor = .borderMain
        case .secondary:
            viewProperties.backgroundColor = .borderSecondary
        }
    }
}

private enum Constant {
    static let thickness: CGFloat = 1
}
