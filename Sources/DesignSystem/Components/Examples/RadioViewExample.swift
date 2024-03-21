import UIKit
import Components

private func example() {
    let view = RadioView()
    var viewProperties = RadioView.ViewProperties()
    viewProperties = RadioViewStyle.update(size: .large, viewProperties: viewProperties)
    viewProperties = RadioViewStyle.update(state: .default, action: .on, viewProperties: viewProperties)
    view.update(viewProperties: viewProperties)
    viewProperties = RadioViewStyle.update(state: .default, action: .off, viewProperties: viewProperties)
    view.update(viewProperties: viewProperties)
}
