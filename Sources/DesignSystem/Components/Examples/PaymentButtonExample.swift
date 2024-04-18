import UIKit
import Components

private func example() {
    let view = PaymentButton()
    let style = PaymentButtonStyle()
    var viewProperties = PaymentButton.ViewProperties(
        text: "Добавить в".attributed,
        image: .ic24Bill.withTintColor(style.tintColor()),
        onTap: { print("tapped") })
    style.update(viewProperties: &viewProperties)
    view.update(with: viewProperties)
}
