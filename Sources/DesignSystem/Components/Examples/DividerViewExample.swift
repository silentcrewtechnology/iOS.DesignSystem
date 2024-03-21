import UIKit
import Components

/// Обычный divider
private func example1() {
    let view = divider(orientation: .horizontal, style: .action)
}

/// Пример с отступами от границ супервью
private func example2() {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.spacing = .zero
    stack.addArrangedSubview(spacer(width: 16))
    stack.addArrangedSubview(divider(orientation: .vertical, style: .main))
}

private func divider(
    orientation: DividerViewStyle.Orientation,
    style: DividerViewStyle.Style
) -> UIView {
    let divider = DividerView()
    var vp = DividerView.ViewProperties()
    vp = DividerViewStyle.update(orientation: orientation, style: style, viewProperties: vp)
    divider.update(with: vp)
    return divider
}

private func spacer(
    width: CGFloat = 1,
    height: CGFloat = 1
) -> UIView {
    let spacer = SpacerView()
    spacer.update(with: .init(size: .init(
        width: width,
        height: height)))
    return spacer
}
