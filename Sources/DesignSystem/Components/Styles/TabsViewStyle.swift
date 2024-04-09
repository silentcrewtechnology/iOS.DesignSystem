import UIKit
import Colors
import Components

public struct TabViewStyle {
    
    public init() { }
    
    public func update(
        viewProperties: inout TabsView.ViewProperties
    ) {
        viewProperties.height = 56
        updateItems(viewProperties: &viewProperties)
        viewProperties.divider = DividerViewStyle.update(
            orientation: .horizontal,
            style: .action,
            viewProperties: viewProperties.divider)
        viewProperties.animationDuration = 0.3
    }
    
    private func updateItems(
        viewProperties: inout TabsView.ViewProperties
    ) {
        for (index, item) in viewProperties.items.enumerated() {
            let textColor: UIColor = viewProperties.selectedTabIndex == index
            ? .contentPrimary
            : .contentSecondary
            viewProperties.items[index].text = item.text
                .fontStyle(.textM)
                .foregroundColor(textColor)
        }
    }
}
