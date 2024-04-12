import UIKit
import Components

private func example() {
    let view = RadioView()
    var viewProperties = RadioView.ViewProperties()
    let style = RadioViewStyle()
    style.update(size: .large,
                 action: .on,
                 state: .default,
                 viewProperties: &viewProperties)
    view.update(with: viewProperties)
    
    style.update(size: .large,
                 action: .off,
                 state: .default,
                 viewProperties: &viewProperties)
    view.update(with: viewProperties)
}
