import Foundation
import Components

private func example() {
    let style = InputOTPItemViewStyle()
    let view = InputOTPItemView()
    var viewProperties = InputOTPItemView.ViewProperties(text: "0".attributed)
    style.update(state: .default, viewProperties: &viewProperties)
    view.update(with: viewProperties)
    style.update(state: .active, viewProperties: &viewProperties)
    view.update(with: viewProperties)
    style.update(state: .error, viewProperties: &viewProperties)
    view.update(with: viewProperties)
    style.update(state: .disabled, viewProperties: &viewProperties)
    view.update(with: viewProperties)
}
