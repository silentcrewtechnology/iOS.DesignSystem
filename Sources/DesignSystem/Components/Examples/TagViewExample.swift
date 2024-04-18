import UIKit
import Components

private func example() {
    let view = TagView()
    let style = TagViewStyle(variant: .info, size: .sizeS)
    var viewProperties = TagView.ViewProperties(
        leftProperties: .init(
            inner: .init(view: {
                UIImageView(
                    image: .ic16InfoCircleOutline.withTintColor(style.tintColor()))
            }()),
            onTap: { print("tapped left") }),
        text: "Label".attributed,
        rightProperties: .init(
            inner: .init(view: {
                UIImageView(
                    image: .ic16Close.withTintColor(style.tintColor()))
            }()),
            onTap: { print("tapped right") }))
    style.update(with: &viewProperties)
    view.update(with: viewProperties)
}
