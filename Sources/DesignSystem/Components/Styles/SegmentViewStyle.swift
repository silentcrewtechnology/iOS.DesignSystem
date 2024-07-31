import UIKit
import Colors
import Components

public struct SegmentViewStyle {
    
    private typealias ViewProperties = SegmentView.ViewProperties
    
    public enum Background {
        case primary
        case secondary
    }
    
    public enum Size {
        case sizeS
        case sizeL
    }
    
    public enum Variant {
        case `default`
        case action
    }
    
    private let background: Background
    private let size: Size
    private let variant: Variant
    
    public init(
        background: Background,
        size: Size,
        variant: Variant
    ) {
        self.background = background
        self.size = size
        self.variant = variant
    }
    
    public func update(
        viewProperties: inout SegmentView.ViewProperties
    ) {
        viewProperties.backgroundColor = background.color()
        viewProperties.height = size.height()
        for index in viewProperties.items.indices {
            viewProperties.items[index].text = viewProperties.items[index].text
                .fontStyle(size.fontStyle())
                .alignment(.center)
        }
        viewProperties.slider = .init(
            backgroundColor: variant.sliderBackgroundColor(),
            cornerRadius: 6)
        updateItemsColors(viewProperties: &viewProperties)
        updateItemsDividers(viewProperties: &viewProperties)
        viewProperties.cornerRadius = 8
        viewProperties.animationDuration = 0.3
    }
    
    private func updateItemsColors(
        viewProperties: inout SegmentView.ViewProperties
    ) {
        let textColors = variant.textColors()
        for index in viewProperties.items.indices {
            viewProperties.items[index].text = viewProperties.items[index].text
                .foregroundColor(
                    viewProperties.selectedSegmentIndex == index
                    ? textColors.active
                    : textColors.inactive)
        }
    }
    
    private func updateItemsDividers(
        viewProperties: inout SegmentView.ViewProperties
    ) {
        let selectedSegmentIndex = viewProperties.selectedSegmentIndex
        for index in viewProperties.items.indices {
            if
                index == selectedSegmentIndex
                || index == selectedSegmentIndex - 1
                || index == viewProperties.items.count - 1
            {
                viewProperties.items[index].divider = .init()
            } else {
                DividerViewStyle(
                    variant: .fixed(.init(width: 1, height: 24)),
                    style: .main)
                .update(viewProperties: &viewProperties.items[index].divider)
            }
        }
    }
}

public extension SegmentViewStyle.Background {
    
    func color() -> UIColor {
        switch self {
        case .primary: .backgroundPrimary
        case .secondary: .backgroundSecondary
        }
    }
}

public extension SegmentViewStyle.Size {
    
    func height() -> CGFloat {
        switch self {
        case .sizeS: 36
        case .sizeL: 56
        }
    }
    
    func fontStyle() -> FontStyle {
        switch self {
        case .sizeS: .textS
        case .sizeL: .textM
        }
    }
}

public extension SegmentViewStyle.Variant {
    
    func sliderBackgroundColor() -> UIColor {
        switch self {
        case .default: .backgroundMain
        case .action: .backgroundAction
        }
    }
    
    func textColors() -> (active: UIColor, inactive: UIColor) {
        switch self {
        case .default: (.contentPrimary, .contentSecondary)
        case .action: (.contentActionOn, .contentSecondary)
        }
    }
}
