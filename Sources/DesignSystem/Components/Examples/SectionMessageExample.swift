import UIKit
import Components

private func example() {
    let view = SectionMessageView()
    
    var viewProperties = SectionMessageView.ViewProperties(
        title: .init(string: "Some text here"),
        backgroundColor: .red
    )
    view.update(with: viewProperties)
    
    SectionMessageStyle.error.update(with: &viewProperties)
    view.update(with: viewProperties)
    
    SectionMessageStyle.success.update(with: &viewProperties)
    view.update(with: viewProperties)
    
}
