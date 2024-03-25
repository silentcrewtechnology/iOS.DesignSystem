import UIKit
import Colors
import Components

public enum SegmentViewStyle {
    
    public enum Background {
        case primary
        case secondary
    }
    
    public enum Size {
        case small
        case medium
    }
    
    public enum Style {
        case `default`
        case action
    }
    
    public static func update(
        background: Background,
        viewProperties: SegmentView.ViewProperties
    ) -> SegmentView.ViewProperties {
        var viewProperties = viewProperties
        switch background {
        case .primary:
            viewProperties.backgroundColor = .backgroundPrimary
        case .secondary:
            viewProperties.backgroundColor = .backgroundSecondary
        }
        return viewProperties
    }
    
    public static func update(
        size: Size,
        viewProperties: SegmentView.ViewProperties
    ) -> SegmentView.ViewProperties {
        var viewProperties = viewProperties
        switch size {
        case .small:
            viewProperties.height = 36
            for (index, item) in viewProperties.items.enumerated() {
                viewProperties.items[index].text = item.text
                    .fontStyle(.textS)
                    .alignment(.center)
            }
        case .medium:
            viewProperties.height = 56
            for (index, item) in viewProperties.items.enumerated() {
                viewProperties.items[index].text = item.text
                    .fontStyle(.textM)
                    .alignment(.center)
            }
        }
        viewProperties.cornerRadius = 8
        return viewProperties
    }
    
    public static func update(
        style: Style,
        viewProperties: SegmentView.ViewProperties
    ) -> SegmentView.ViewProperties {
        var viewProperties = viewProperties
        switch style {
        case .default:
            viewProperties = updateItemsColors(
                activeColor: .contentPrimary,
                inactiveColor: .contentSecondary,
                viewProperties: viewProperties)
            viewProperties.slider = .init(
                backgroundColor: .backgroundMain,
                cornerRadius: Constant.sliderCornerRadius)
        case .action:
            viewProperties = updateItemsColors(
                activeColor: .contentActionOn,
                inactiveColor: .contentSecondary,
                viewProperties: viewProperties)
            viewProperties.slider = .init(
                backgroundColor: .backgroundAction,
                cornerRadius: Constant.sliderCornerRadius)
        }
        viewProperties = updateItemsDividers(viewProperties: viewProperties)
        viewProperties.animationDuration = Constant.animationDuration
        return viewProperties
    }
    
    private static func updateItemsColors(
        activeColor: UIColor,
        inactiveColor: UIColor,
        viewProperties: SegmentView.ViewProperties
    ) -> SegmentView.ViewProperties {
        var viewProperties = viewProperties
        for (index, item) in viewProperties.items.enumerated() {
            if viewProperties.selectedSegmentIndex == index {
                viewProperties.items[index].text = item.text
                    .foregroundColor(activeColor)
            } else {
                viewProperties.items[index].text = item.text
                    .foregroundColor(inactiveColor)
            }
        }
        return viewProperties
    }
    
    private static func updateItemsDividers(
        viewProperties: SegmentView.ViewProperties
    ) -> SegmentView.ViewProperties {
        var viewProperties = viewProperties
        let selectedSegmentIndex = viewProperties.selectedSegmentIndex
        for index in viewProperties.items.indices {
            if
                index == selectedSegmentIndex
                || index == selectedSegmentIndex - 1
                || index == viewProperties.items.count - 1
            {
                viewProperties.items[index].divider = .init()
            } else {
                viewProperties.items[index].divider = DividerViewStyle.update(
                    orientation: .fixed(.init(width: 1, height: 24)),
                    style: .main,
                    viewProperties: viewProperties.items[index].divider)
            }
        }
        return viewProperties
    }
}

private enum Constant {
    static let animationDuration: TimeInterval = 0.3
    static let viewCornerRadius: CGFloat = 8
    static let sliderCornerRadius: CGFloat = 6
}
