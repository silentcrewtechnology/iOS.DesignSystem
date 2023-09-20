import UIKit

private func example() {
    let view = RadioView()
    var viewProperties = RadioView.ViewProperties()
    view.create(with: viewProperties)
    viewProperties = RadioViewStyle.update(size: .large, viewProperties: viewProperties)
    viewProperties = RadioViewStyle.update(state: .default, action: .on, viewProperties: viewProperties)
    view.update(with: viewProperties)
    viewProperties = RadioViewStyle.update(state: .default, action: .off, viewProperties: viewProperties)
    view.update(with: viewProperties)
}
