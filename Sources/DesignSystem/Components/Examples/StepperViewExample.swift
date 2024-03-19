import Foundation

private func example() {
    let view = StepperView()
    let allCount = 5
    var viewProperties = StepperView.ViewProperties(
        items: (0..<allCount).map { _ in .init() },
        height: 4)
    // 40% progress
    let activeCount40 = 2
    for (index, item) in viewProperties.items.enumerated() {
        viewProperties.items[index] = StepperItemViewStyle.reactivate(
            variant: index < activeCount40 ? .active : .disabled,
            viewProperties: item)
    }
    view.update(with: viewProperties)
    // 60% progress
    let activeCount60 = 3
    for (index, item) in viewProperties.items.enumerated() {
        viewProperties.items[index] = StepperItemViewStyle.reactivate(
            variant: index < activeCount60 ? .active : .disabled,
            viewProperties: item)
    }
    view.update(with: viewProperties)
}
