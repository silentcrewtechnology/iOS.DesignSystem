import UIKit
import Components

public final class InputAmountViewStyle {
    
    // MARK: - Properties
    
    public enum State {
        case `default`
        case active
        case error
        case disabled
    }
    
    public private(set) var state: State
    
    // MARK: - Init
    
    public init(
        state: State
    ) {
        self.state = state
    }
    
    // MARK: - Methods
    
    public func update(
        state: State? = nil,
        viewProperties: inout InputAmountView.ViewProperties
    ) {
        if let state {
            self.state = state
        }
        
        // TODO: - Заменить, когда будет в json
        viewProperties.textFieldProperties.cursorColor = .Components.InputAmount.Content.Color.default
        viewProperties.isUserInteractionEnabled = self.state.isUserInteractionEnabled()
        viewProperties.margins = getMargins()
        viewProperties.textFieldProperties.textAttributes = textFieldAttributes()
        viewProperties.textFieldProperties.text = viewProperties.textFieldProperties.text
            .fontStyle(Constants.defaultTextStyle)
            .foregroundColor(textFieldTextColor())
        viewProperties.textFieldProperties.placeholder = viewProperties.textFieldProperties.placeholder
            .fontStyle(Constants.defaultTextStyle)
            .foregroundColor(textFieldPlaceholderColor())
        viewProperties.amountSymbol = viewProperties.amountSymbol
            .fontStyle(Constants.defaultTextStyle)
            .foregroundColor(textFieldPrefixColor())
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

// MARK: - InputAmountViewStyle Extension

extension InputAmountViewStyle {
    
    private func textFieldAttributes() -> [NSAttributedString.Key: Any] {
        switch state {
        case .default:
            return [
                .font: Constants.defaultTextStyle.font,
                .foregroundColor: UIColor.Components.InputAmount.Content.Color.default,
                .paragraphStyle: {
                    let style = NSMutableParagraphStyle()
                    style.minimumLineHeight = Constants.defaultTextStyle.lineHeight
                    style.maximumLineHeight = Constants.defaultTextStyle.lineHeight
                    return style
                }(),
                // почему-то нужен двойной отступ для Roboto
                .baselineOffset: Constants.defaultTextStyle.baselineOffset * 2
            ]
        case .active:
            return [
                .font: Constants.defaultTextStyle.font,
                .foregroundColor: UIColor.Components.InputAmount.Content.Color.active,
                .paragraphStyle: {
                    let style = NSMutableParagraphStyle()
                    style.minimumLineHeight = Constants.defaultTextStyle.lineHeight
                    style.maximumLineHeight = Constants.defaultTextStyle.lineHeight
                    return style
                }(),
                // почему-то нужен двойной отступ для Roboto
                .baselineOffset: Constants.defaultTextStyle.baselineOffset * 2
            ]
        case .error:
            return [
                .font: Constants.defaultTextStyle.font,
                .foregroundColor: UIColor.Components.InputAmount.Content.Color.error,
                .paragraphStyle: {
                    let style = NSMutableParagraphStyle()
                    style.minimumLineHeight = Constants.defaultTextStyle.lineHeight
                    style.maximumLineHeight = Constants.defaultTextStyle.lineHeight
                    return style
                }(),
                // почему-то нужен двойной отступ для Roboto
                .baselineOffset: Constants.defaultTextStyle.baselineOffset * 2
            ]
        case .disabled:
            return [
                .font: Constants.defaultTextStyle.font,
                .foregroundColor: UIColor.Components.InputAmount.Content.Color.disabled,
                .paragraphStyle: {
                    let style = NSMutableParagraphStyle()
                    style.minimumLineHeight = Constants.defaultTextStyle.lineHeight
                    style.maximumLineHeight = Constants.defaultTextStyle.lineHeight
                    return style
                }(),
                // почему-то нужен двойной отступ для Roboto
                .baselineOffset: Constants.defaultTextStyle.baselineOffset * 2
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

// MARK: - InputAmountViewStyle.State Extension

public extension InputAmountViewStyle.State {
    
    func isUserInteractionEnabled() -> Bool {
        switch self {
        case .disabled: false
        default: true
        }
    }
}

// MARK: - Constants

private enum Constants {
    static let defaultTextStyle: FontStyle = .text4XL
}
