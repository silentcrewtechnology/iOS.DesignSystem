import Foundation
import Components

private func example() {
    let view = InputOTPView()
    let viewProperties = InputOTPView.ViewProperties(
        items: otpItems(),
        hint: hintProperties())
    view.update(with: viewProperties)
}

private func otpItems() -> [InputOTPItemView.ViewProperties] {
    let states: [InputOTPItemViewStyle.State] = [.default, .active, .error, .disabled]
    return states.map { state in
        let style = InputOTPItemViewStyle()
        var viewProperties = InputOTPItemView.ViewProperties()
        style.update(state: state, viewProperties: &viewProperties)
        return viewProperties
    }
}

private func hintProperties() -> HintView.ViewProperties {
    var viewProperties = HintView.ViewProperties()
    HintViewStyle().update(
        variant: .right("Hint".attributed),
        viewProperties: &viewProperties)
    return viewProperties
}
