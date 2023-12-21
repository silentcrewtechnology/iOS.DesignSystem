import UIKit

private func example() {
    let view = MessageView()
    var viewProperties = MessageViewStyle.updateStyle(
        style: .default,
        viewProperties: .init(
            attributedText: "Content".attributed,
            attributedPlaceholder: "PlaceHolder".attributed
        )
    )
    
    view.create(with: viewProperties)
    viewProperties = MessageViewStyle.updateStyle(style: .disabled, viewProperties: .init())
    view.update(viewProperties: viewProperties)
}
