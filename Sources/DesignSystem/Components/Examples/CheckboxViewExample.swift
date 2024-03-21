import UIKit
import Components

private func example() {
    let view = CheckboxView()
    var viewProperties = CheckboxView.ViewProperties()
    viewProperties = CheckboxViewStyle.update(size: .small, viewProperties: viewProperties)
    viewProperties = CheckboxViewStyle.update(state: .default, action: .on, viewProperties: viewProperties)
    view.update(with: viewProperties)
    viewProperties = CheckboxViewStyle.update(state: .default, action: .off, viewProperties: viewProperties)
    view.update(with: viewProperties)
}
