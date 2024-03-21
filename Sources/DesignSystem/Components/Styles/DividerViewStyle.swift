import UIKit
import Components
import Colors

public enum DividerViewStyle {
    
    public typealias ViewProperties = DividerView.ViewProperties
    
    public enum Orientation {
        case horizontal
        case vertical
    }
    
    public enum Style {
        case action
        case main
        case secondary
    }
    
    public static func update(
        orientation: Orientation,
        style: Style,
        viewProperties: ViewProperties
    ) -> ViewProperties {
        var viewProperties = viewProperties
        viewProperties = update(orientation: orientation, viewProperties: viewProperties)
        viewProperties = update(style: style, viewProperties: viewProperties)
        return viewProperties
    }
    
    private static func update(
        orientation: Orientation,
        viewProperties: ViewProperties
    ) -> ViewProperties {
        var viewProperties = viewProperties
        switch orientation {
        case .horizontal:
            viewProperties.size = .height(Constant.thickness)
        case .vertical:
            viewProperties.size = .width(Constant.thickness)
        }
        return viewProperties
    }
    
    private static func update(
        style: Style,
        viewProperties: ViewProperties
    ) -> ViewProperties {
        var viewProperties = viewProperties
        switch style {
        case .action:
            viewProperties.backgroundColor = .borderAction
        case .main:
            viewProperties.backgroundColor = .borderMain
        case .secondary:
            viewProperties.backgroundColor = .borderSecondary
        }
        return viewProperties
    }
}

private enum Constant {
    static let thickness: CGFloat = 1
}
