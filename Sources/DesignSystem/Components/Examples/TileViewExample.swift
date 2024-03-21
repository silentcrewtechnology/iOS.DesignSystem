import UIKit
import Components

private func example() {
    let view = TileView()
    var viewProperties = TileView.ViewProperties(
        icon: .init(variant: .icon(UIImage())),
        text: .init(string: "Example"),
        action: { print("Example") })
    viewProperties = TileViewStyle.resize(size: .large, viewProperties: viewProperties)
    viewProperties = TileViewStyle.restyle(style: .primary, viewProperties: viewProperties)
    view.update(with: viewProperties)
}
