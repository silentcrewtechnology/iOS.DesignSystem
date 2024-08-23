import UIKit
import Components

public final class InputAmountViewStyle {
    
    public enum State {
        case `default`
        case active
        case error
        case disabled
    }
    
    private var state: State
    private var hintStyle: HintViewStyle?
    private var headerStyle: LabelViewStyle?
    
    public init(
        state: State,
        hintStyle: HintViewStyle? = nil,
        headerStyle: LabelViewStyle? = nil
    ) {
        self.state = state
        self.hintStyle = hintStyle
        self.headerStyle = headerStyle
    }
    
    public func update(
        state: State? = nil,
        hintVariant: HintViewStyle.Variant? = nil,
        headerVariant: LabelViewStyle.Variant? = nil,
        viewProperties: inout InputAmountView.ViewProperties
    ) {
        if let state {
            self.state = state
        }
        
        //TODO: заменить когда Лена добавит в json
        viewProperties.textFieldProperties.cursorColor = .Components.InputAmount.Content.Color.default
        
        if viewProperties.hintViewProperties != nil {
            updateHintStyle(state: self.state,
                            variant: hintVariant,
                            viewProperties: &viewProperties.hintViewProperties!)
        }
        
        if viewProperties.headerViewProperties != nil {
            updateHeaderStyle(variant: headerVariant,
                              viewProperties: &viewProperties.headerViewProperties!)
        }
        
        switch self.state {
        case .default:
            viewProperties.isUserInteractionEnabled = true
            viewProperties.textFieldProperties.textAttributes = textFieldAttributes()
            viewProperties.textFieldProperties.text = viewProperties.textFieldProperties.text
                .fontStyle(Constant.defaultTextStyle)
                .foregroundColor(textFieldTextColor())
            viewProperties.textFieldProperties.placeholder = viewProperties.textFieldProperties.placeholder
                .fontStyle(Constant.defaultTextStyle)
                .foregroundColor(textFieldPlaceholderColor())
            viewProperties.amountSymbol = viewProperties.amountSymbol
                .fontStyle(Constant.defaultTextStyle)
                .foregroundColor(textFieldPrefixColor())
            
        case .active:
            viewProperties.isUserInteractionEnabled = true
            viewProperties.textFieldProperties.textAttributes = textFieldAttributes()
            viewProperties.textFieldProperties.text = viewProperties.textFieldProperties.text
                .fontStyle(Constant.defaultTextStyle)
                .foregroundColor(textFieldTextColor())
            viewProperties.textFieldProperties.placeholder = viewProperties.textFieldProperties.placeholder
                .fontStyle(Constant.defaultTextStyle)
                .foregroundColor(textFieldPlaceholderColor())
            
        case .error:
            viewProperties.isUserInteractionEnabled = true
            viewProperties.textFieldProperties.textAttributes = textFieldAttributes()
            viewProperties.textFieldProperties.text = viewProperties.textFieldProperties.text
                .fontStyle(Constant.defaultTextStyle)
                .foregroundColor(textFieldTextColor())
            viewProperties.textFieldProperties.placeholder = viewProperties.textFieldProperties.placeholder
                .fontStyle(Constant.defaultTextStyle)
                .foregroundColor(textFieldPlaceholderColor())
            viewProperties.amountSymbol = viewProperties.amountSymbol
                .fontStyle(Constant.defaultTextStyle)
                .foregroundColor(textFieldPrefixColor())
       
        case .disabled:
            viewProperties.isUserInteractionEnabled = false
            viewProperties.textFieldProperties.textAttributes = textFieldAttributes()
            viewProperties.textFieldProperties.text = viewProperties.textFieldProperties.text
                .fontStyle(Constant.defaultTextStyle)
                .foregroundColor(textFieldTextColor())
            viewProperties.textFieldProperties.placeholder = viewProperties.textFieldProperties.placeholder
                .fontStyle(Constant.defaultTextStyle)
                .foregroundColor(textFieldPlaceholderColor())
            viewProperties.amountSymbol = viewProperties.amountSymbol
                .fontStyle(Constant.defaultTextStyle)
                .foregroundColor(textFieldPrefixColor())
            
        }
        
        viewProperties.margins = getMargins()
    }
    
    private func updateHintStyle(
        state: State,
        variant: HintViewStyle.Variant?,
        viewProperties: inout HintView.ViewProperties
    ) {
        let color: HintViewStyle.Color
        switch state {
        case .active:
            color = .active
        case .default:
            color = .default
        case .disabled:
            color = .disabled
        case .error:
            color = .error
        }
        
        hintStyle?.update(
            variant: variant,
            color: color,
            viewProperties: &viewProperties)
    }
    
    private func updateHeaderStyle(
        variant: LabelViewStyle.Variant? = nil,
        viewProperties: inout LabelView.ViewProperties
    ) {
        headerStyle?.update(
            variant: variant,
            viewProperties: &viewProperties)
    }
    
    private func getMargins() -> InputAmountView.ViewProperties.Margins {
        return .init(
            top: 0,
            trailing: 0,
            leading: 0,
            bottom: 0,
            spacing: 8)
    }
}

extension InputAmountViewStyle {
    private func textFieldAttributes() -> [NSAttributedString.Key: Any] {
        switch state {
        case .default:
            return [
                .font: Constant.defaultTextStyle.font,
                .foregroundColor: UIColor.Components.InputAmount.Content.Color.default,
                .paragraphStyle: {
                    let style = NSMutableParagraphStyle()
                    style.minimumLineHeight = Constant.defaultTextStyle.lineHeight
                    style.maximumLineHeight = Constant.defaultTextStyle.lineHeight
                    return style
                }(),
                // почему-то нужен двойной отступ для Roboto
                .baselineOffset: Constant.defaultTextStyle.baselineOffset * 2
            ]
        case .active:
            return [
                .font: Constant.defaultTextStyle.font,
                .foregroundColor: UIColor.Components.InputAmount.Content.Color.active,
                .paragraphStyle: {
                    let style = NSMutableParagraphStyle()
                    style.minimumLineHeight = Constant.defaultTextStyle.lineHeight
                    style.maximumLineHeight = Constant.defaultTextStyle.lineHeight
                    return style
                }(),
                // почему-то нужен двойной отступ для Roboto
                .baselineOffset: Constant.defaultTextStyle.baselineOffset * 2
            ]
        case .error:
            return [
                .font: Constant.defaultTextStyle.font,
                .foregroundColor: UIColor.Components.InputAmount.Content.Color.error,
                .paragraphStyle: {
                    let style = NSMutableParagraphStyle()
                    style.minimumLineHeight = Constant.defaultTextStyle.lineHeight
                    style.maximumLineHeight = Constant.defaultTextStyle.lineHeight
                    return style
                }(),
                // почему-то нужен двойной отступ для Roboto
                .baselineOffset: Constant.defaultTextStyle.baselineOffset * 2
            ]
        case .disabled:
            return [
                .font: Constant.defaultTextStyle.font,
                .foregroundColor: UIColor.Components.InputAmount.Content.Color.disabled,
                .paragraphStyle: {
                    let style = NSMutableParagraphStyle()
                    style.minimumLineHeight = Constant.defaultTextStyle.lineHeight
                    style.maximumLineHeight = Constant.defaultTextStyle.lineHeight
                    return style
                }(),
                // почему-то нужен двойной отступ для Roboto
                .baselineOffset: Constant.defaultTextStyle.baselineOffset * 2
            ]
        }
    }
    
    private func textFieldTextColor() -> UIColor {
        switch state {
        case .default: .Components.InputAmount.Content.Color.default
        case .active: .Components.InputAmount.Content.Color.active
        case .error: .Components.InputAmount.Content.Color.error
        case .disabled: .Components.InputAmount.Content.Color.disabled
        }
    }
    
    private func textFieldPlaceholderColor() -> UIColor {
        switch state {
        case .default: .Components.InputAmount.Placeholder.Color.default
        case .active: .Components.InputAmount.Placeholder.Color.active
        case .error: .Components.InputAmount.Placeholder.Color.error
        case .disabled: .Components.InputAmount.Placeholder.Color.disabled
        }
    }
    
    private func textFieldPrefixColor() -> UIColor {
        switch state {
        case .default: .Components.InputAmount.Prefix.Color.default
        case .active: .Components.InputAmount.Prefix.Color.active
        case .error: .Components.InputAmount.Prefix.Color.error
        case .disabled: .Components.InputAmount.Prefix.Color.disabled
        }
    }
}

private enum Constant {
    static let defaultTextStyle: FontStyle = .text4XL
}
