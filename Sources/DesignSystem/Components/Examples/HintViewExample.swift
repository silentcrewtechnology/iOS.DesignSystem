import Foundation
import Components
import Colors

private func example() {
    let view = HintView()
    var viewProperties = HintView.ViewProperties()
    let style = HintViewStyle()
    style.update(
        variant: .empty,
        viewProperties: &viewProperties)
    view.update(with: viewProperties)
    style.update(
        variant: .left("Left".attributed.foregroundColor(.contentInfo)),
        viewProperties: &viewProperties)
    view.update(with: viewProperties)
    style.update(
        variant: .right("Right".attributed.foregroundColor(.contentAction)),
        viewProperties: &viewProperties)
    view.update(with: viewProperties)
    style.update(
        variant: .both("Left".attributed, "Right".attributed),
        viewProperties: &viewProperties)
    view.update(with: viewProperties)
}
