import Foundation

private func example() {
    let view = StepperView()
    let allCount = 5
    var viewProperties = StepperView.ViewProperties(
        items: (0..<allCount).map { _ in .init() },
        height: 4)
    view.create(with: viewProperties)
    // 40% progress
    let activeCount = 2
    for (index, item) in viewProperties.items.enumerated() {
        viewProperties.items[index] = StepperItemViewStyle.reactivate(
            variant: index < activeCount ? .active : .disabled,
            viewProperties: item)
    }
    view.update(with: viewProperties)
}
