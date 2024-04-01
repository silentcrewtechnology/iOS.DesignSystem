import UIKit
import Components

private func example() {
    let view = TagView()
    let style = TagViewStyle(variant: .info, size: .sizeS)
    var viewProperties = TagView.ViewProperties(text: "Label".attributed)
    style.update(with: &viewProperties)
    view.update(with: viewProperties)
}
