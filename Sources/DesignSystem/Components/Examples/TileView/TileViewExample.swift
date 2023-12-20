import UIKit

private func example() {
    let view = TileView()
    var viewProperties = TileView.ViewProperties(
        icon: .init(variant: .icon(UIImage())),
        text: .init(string: "Example"),
        action: { print("Example") })
    view.create(with: viewProperties)
    viewProperties = TileViewStyle.resize(size: .large, viewProperties: viewProperties)
    viewProperties = TileViewStyle.restyle(style: .primary, viewProperties: viewProperties)
    view.update(viewProperties: viewProperties)
}
