import UIKit
import Components

private func example() {
    // Пример стандартного textView
    let plainView = TextBlockView()
    var plainViewProperties = TextBlockView.ViewProperties(text: .init(string: "Some your text here..."))
    let plainStyle = TextBlockViewStyle()
    plainStyle.update(variant: .plain,
                 viewProperties: &plainViewProperties)
    plainView.update(with: plainViewProperties)
    
    // Пример с textView с title и иконкой
    let view = TextBlockView()
    var viewProperties = TextBlockView.ViewProperties(
        text: .init(string: "Some your text here..."),
        title: .init(string: "Title")
    )
    let style = TextBlockViewStyle()
    style.update(variant: .iconNumberWithBackground(number: LimitedNumber(number: 0)),
                 viewProperties: &viewProperties)
    style.update(variant: .iconNumberWithBackground(number: LimitedNumber(number: 99)),
                 viewProperties: &viewProperties)
    view.update(with: viewProperties)
}

