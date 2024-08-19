import UIKit
import Components
import Colors

public struct InputAmountViewStyle {
    
    public enum State {
        case `default`
        case error(NSMutableAttributedString)
        case disabled
    }
    
    public init() { }
    
    private let styleHint = OldHintViewStyle()
    
    public func update(
        state: State,
        viewProperties: inout InputAmountView.ViewProperties
    ) {
        viewProperties.textFieldProperties.cursorColor = .contentPrimary
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
            styleHint.update(variant: .empty, 
                             viewProperties: &viewProperties.hint)
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
            styleHint.update(variant: .left(message),
                             viewProperties: &viewProperties.hint)
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
            styleHint.update(variant: .empty,
                             viewProperties: &viewProperties.hint)
        }
    }
}

private enum Constant {
    
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
