import UIKit
import Components

private func example() {
    // Пример стандартного textView
    let plainView = TextBlockView()
    var plainViewProperties = TextBlockView.ViewProperties(text: .init(string: "Some your text here..."))
    plainViewProperties = TextBlockViewStyle.plain.update(viewProperties: &plainViewProperties)
    plainView.update(with: plainViewProperties)
    
    // Пример с textView с title и иконкой
    let view = TextBlockView()
    var viewProperties = TextBlockView.ViewProperties(
        text: .init(string: "Some your text here..."),
        title: .init(string: "Title")
    )
    viewProperties = TextBlockViewStyle.iconNumberWithBackground(number: LimitedNumber(number: 0)).update(viewProperties: &viewProperties)
    viewProperties = TextBlockViewStyle.iconNumberWithBackground(number: LimitedNumber(number: 99)).update(viewProperties: &viewProperties)
    view.update(with: viewProperties)
}

