import Foundation
import Components

private func example() {
    let view = StepperView()
    let allCount = 5
    var viewProperties = StepperView.ViewProperties(
        items: (0..<allCount).map { _ in .init() },
        height: 4)
    // 40% progress
    let activeCount40 = 2
    for index in viewProperties.items.indices {
        viewProperties.items[index] = createItemViewProperty(activeCount: activeCount40, index: index)
    }
    view.update(with: viewProperties)
    // 60% progress
    let activeCount60 = 3
    for index in viewProperties.items.indices {
        viewProperties.items[index] = createItemViewProperty(activeCount: activeCount60, index: index)
    }
    view.update(with: viewProperties)
}

private func createItemViewProperty(activeCount: Int, index: Int) -> StepperItemView.ViewProperties {
        var itemViewProperties = StepperItemView.ViewProperties()
        let style = StepperItemViewStyle()
        let state: StepperItemViewStyle.State
        
        if index < activeCount {
            state = .success
        } else if index == activeCount {
            state = .active
        } else {
            state = .next
        }
        
        style.update(state: state,
                     viewProperties: &itemViewProperties)
        return itemViewProperties
}
