import UIKit

public enum InputAmountViewStyle {
    
    public enum State {
        case `default`
        case error(String)
        case disabled
    }
    
    public static func update(
        state: State,
        viewProperties: InputAmountView.ViewProperties
    ) -> InputAmountView.ViewProperties {
        var viewProperties = viewProperties
        viewProperties.title = viewProperties.title
            .fontStyle(.textS)
            .foregroundColor(.contentSecondary)
        switch state {
        case .default:
            viewProperties.isUserInteractionEnabled = true
            viewProperties.textFieldProperties.textAttributes = Constant.defaultTextAttributes
            viewProperties.textFieldProperties.text = viewProperties.textFieldProperties.text
                .fontStyle(Constant.defaultTextStyle)
                .foregroundColor(.contentPrimary)
            viewProperties.textFieldProperties.placeholder = viewProperties.textFieldProperties.placeholder
                .fontStyle(Constant.defaultTextStyle)
                .foregroundColor(.contentSecondary)
            viewProperties.amountSymbol = viewProperties.amountSymbol
                .fontStyle(Constant.defaultTextStyle)
                .foregroundColor(.contentTertiary)
            viewProperties.hint = viewProperties.hint
                .fontStyle(Constant.defaultTitleHintStyle)
                .foregroundColor(.contentSecondary)
        case .error(let message):
            viewProperties.isUserInteractionEnabled = true
            viewProperties.textFieldProperties.textAttributes = Constant.defaultTextAttributes
            viewProperties.textFieldProperties.text = viewProperties.textFieldProperties.text
                .fontStyle(Constant.defaultTextStyle)
                .foregroundColor(.contentPrimary)
            viewProperties.textFieldProperties.placeholder = viewProperties.textFieldProperties.placeholder
                .fontStyle(Constant.defaultTextStyle)
                .foregroundColor(.contentSecondary)
            viewProperties.amountSymbol = viewProperties.amountSymbol
                .fontStyle(Constant.defaultTextStyle)
                .foregroundColor(.contentTertiary)
            viewProperties.hint = message.attributed
                .fontStyle(Constant.defaultTitleHintStyle)
                .foregroundColor(.contentError)
        case .disabled:
            viewProperties.isUserInteractionEnabled = false
            viewProperties.textFieldProperties.textAttributes = Constant.disabledTextAttributes
            viewProperties.textFieldProperties.text = viewProperties.textFieldProperties.text
                .fontStyle(Constant.defaultTextStyle)
                .foregroundColor(.contentDisabled)
            viewProperties.textFieldProperties.placeholder = viewProperties.textFieldProperties.placeholder
                .fontStyle(Constant.defaultTextStyle)
                .foregroundColor(.contentDisabled)
            viewProperties.amountSymbol = viewProperties.amountSymbol
                .fontStyle(Constant.defaultTextStyle)
                .foregroundColor(.contentDisabled)
            viewProperties.hint = viewProperties.hint
                .fontStyle(Constant.defaultTitleHintStyle)
                .foregroundColor(.contentSecondary)
        }
        return viewProperties
    }
}

private enum Constant {
    
    static let defaultTitleHintStyle: FontStyle = .textS
    static let defaultTextStyle: FontStyle = .text4XL
    
    static let defaultTextAttributes: [NSAttributedString.Key: Any] = [
        .font: defaultTextStyle.font,
        .foregroundColor: UIColor.contentPrimary,
        .paragraphStyle: {
            let style = NSMutableParagraphStyle()
            style.minimumLineHeight = defaultTextStyle.lineHeight
            style.maximumLineHeight = defaultTextStyle.lineHeight
            return style
        }(),
        // почему-то нужен двойной отступ для Roboto
        .baselineOffset: defaultTextStyle.baselineOffset * 2
    ]
    
    static let disabledTextAttributes: [NSAttributedString.Key: Any] = [
        .font: defaultTextStyle.font,
        .foregroundColor: UIColor.contentDisabled,
        .paragraphStyle: {
            let style = NSMutableParagraphStyle()
            style.minimumLineHeight = defaultTextStyle.lineHeight
            style.maximumLineHeight = defaultTextStyle.lineHeight
            return style
        }(),
        // почему-то нужен двойной отступ для Roboto
        .baselineOffset: defaultTextStyle.baselineOffset * 2
    ]
}
