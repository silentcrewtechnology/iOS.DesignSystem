import UIKit
import Components
import Colors

public final class LabelViewStyle {
    
    // MARK: - Properties
    
    public enum Variant {
        case `default`(customColor: UIColor?)
        case disabled(customColor: UIColor?)
        @available(*, deprecated, message: "Use rowCustomTitle")
        case rowTitle(recognizer: UILongPressGestureRecognizer?)
        @available(*, deprecated, message: "Use rowCustomSubtitle")
        case rowSubtitle
        case rowIndex
        case rowAmount
        case rowStatusCard(statusCardVariant: StatusCardVariant)
        case rowCustomTitle(customColor: UIColor?, recognizer: UILongPressGestureRecognizer?)
        case rowCustomSubtitle(customColor: UIColor?)
        
        public enum StatusCardVariant {
            case blocked
            case rerelease
            case expires
            case readiness
        }
    }
    
    private var variant: Variant
    private var alignment: NSTextAlignment
    
    // MARK: - Life cycle
    
    public init(
        variant: Variant,
        alignment: NSTextAlignment = .left
    ) {
        self.variant = variant
        self.alignment = alignment
    }
    
    // MARK: - Public methods
    
    public func update(
        variant: Variant? = nil,
        viewProperties: inout LabelView.ViewProperties
    ) {
        if let variant {
            self.variant = variant
        }
        
        viewProperties.longPressGestureRecognizer = self.variant.gestureRecognizer()
        viewProperties.size = .init(
            inset: self.variant.insets(),
            lineHeight: self.variant.lineHeight()
        )
        viewProperties.text = viewProperties.text
            .fontStyle(self.variant.fontStyle())
            .foregroundColor(self.variant.foregroundColor())
            .alignment(self.alignment)
    }
}

// MARK: - LabelViewStyle.Variant Extension

public extension LabelViewStyle.Variant {
    func gestureRecognizer() -> UILongPressGestureRecognizer? {
        switch self {
        case .rowTitle(let recognizer): return recognizer ?? nil
        case .rowCustomTitle(_, let recognizer): return recognizer ?? nil
        default: return nil
        }
    }
    
    func insets() -> UIEdgeInsets {
        switch self {
        case .default(_), .disabled(_): .init(top: 2, left: .zero, bottom: 2, right: .zero)
        default: .zero
        }
    }
    
    func lineHeight() -> CGFloat {
        switch self {
        case .rowSubtitle, .rowCustomSubtitle, .rowIndex: 20
        case .rowStatusCard: 16
        default: 24
        }
    }
    
    func fontStyle() -> FontStyle {
        switch self {
        case .rowTitle(_), .rowCustomTitle(_, _): .textM
        case .rowAmount: .textM_1
        case .rowStatusCard: .text2XS
        default: .textS
        }
    }
    
    func foregroundColor() -> UIColor {
        switch self {
        case .default(let customColor): customColor ?? .Components.Label.Color.color
        case .disabled(let customColor): customColor ?? .Core.Brand.neutral300
        case .rowTitle(_): .Components.Row.Title.Color.value
        case .rowAmount: .Components.Row.Title.Color.value
        case .rowSubtitle: .Components.Row.Subtitle.Color.value
        case .rowIndex: .Components.Row.Index.Color.value
        case .rowStatusCard(let statusCardVariant): statusCardVariant.foregroundColor()
        case .rowCustomTitle(let customColor, _): customColor ?? .Components.Row.Title.Color.value
        case .rowCustomSubtitle(let customColor):
            customColor ?? .Components.Row.Subtitle.Color.value
        }
    }
}

// MARK: - LabelViewStyle.Variant.StatusCardVariant Extension

public extension LabelViewStyle.Variant.StatusCardVariant {
    func foregroundColor() -> UIColor {
        switch self {
        case .blocked: .Semantic.LightTheme.Content.Error.default
        case .rerelease, .expires: .Semantic.LightTheme.Content.Warning.default
        case .readiness: .Semantic.LightTheme.Content.Accent.default
        }
    }
}
