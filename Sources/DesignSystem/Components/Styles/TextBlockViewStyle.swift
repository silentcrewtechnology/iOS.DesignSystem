import UIKit
import Components

public struct TextBlockViewStyle {
    
    public enum Variant {
        case plain
        case marker
        case plainWithBackground
        case markerWithBackground
        case icon(image: UIImage)
        case iconWithBackground(image: UIImage)
        case iconNumber(number: LimitedNumber)
        case iconNumberWithBackground(number: LimitedNumber)
    }
    
    public init() { }
    
    public func update(
        variant: Variant,
        viewProperties: inout TextBlockView.ViewProperties
    ) {
        switch variant {
        case .plain:
            viewProperties.text = viewProperties.text.string.textM(color: .contentPrimary)
            viewProperties.contentInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        case .marker:
            viewProperties.text = viewProperties.text.string.textM(color: .contentPrimary)
            viewProperties.contentInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            viewProperties.isMarked = true
        case .plainWithBackground:
            viewProperties.text = viewProperties.text.string.textM(color: .contentPrimary)
            viewProperties.contentInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            viewProperties.background.color = .backgroundPrimary
            viewProperties.background.cornerRadius = 12
        case .markerWithBackground:
            viewProperties.text = viewProperties.text.string.textM(color: .contentPrimary)
            viewProperties.contentInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
            viewProperties.isMarked = true
            viewProperties.background.color = .backgroundPrimary
            viewProperties.background.cornerRadius = 12
        case .icon(let image):
            viewProperties.text = viewProperties.text.string.textS(color: .contentSecondary)
            viewProperties.title = viewProperties.title.string.textM_1(color: .contentPrimary)
            viewProperties.contentInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            viewProperties.icon = TextBlockView.ViewProperties.Icon()
            viewProperties.icon?.backgroundColor = .backgroundPrimary
            viewProperties.icon?.image = image
        case .iconWithBackground(let image):
            viewProperties.text = viewProperties.text.string.textS(color: .contentSecondary)
            viewProperties.title = viewProperties.title.string.textM_1(color: .contentPrimary)
            viewProperties.contentInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            viewProperties.background.color = .backgroundPrimary
            viewProperties.background.cornerRadius = 12
            viewProperties.icon = TextBlockView.ViewProperties.Icon()
            viewProperties.icon?.backgroundColor = .white
            viewProperties.icon?.image = image
        case .iconNumber(let number):
            viewProperties.text = viewProperties.text.string.textS(color: .contentSecondary)
            viewProperties.title = viewProperties.title.string.textM_1(color: .contentPrimary)
            viewProperties.contentInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            viewProperties.icon = TextBlockView.ViewProperties.Icon()
            viewProperties.icon?.backgroundColor = .backgroundPrimary
            viewProperties.icon?.text = String(number.wrappedValue).textS(color: .contentPrimary)
        case .iconNumberWithBackground(let number):
            viewProperties.text = viewProperties.text.string.textS(color: .contentSecondary)
            viewProperties.title = viewProperties.title.string.textM_1(color: .contentPrimary)
            viewProperties.contentInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            viewProperties.background.color = .backgroundPrimary
            viewProperties.background.cornerRadius = 12
            viewProperties.icon = TextBlockView.ViewProperties.Icon()
            viewProperties.icon?.backgroundColor = .white
            viewProperties.icon?.text = String(number.wrappedValue).textS(color: .contentPrimary)
        }
    }
}

@propertyWrapper
public struct LimitedNumber {
    private var number: Int
    
    public var wrappedValue: Int {
        get { return number }
        set {
            if newValue < 100 && newValue >= 0 {
                number = newValue
            } else {
                assertionFailure("Number must be a two-digit number")
            }
        }
    }
    
    public init(number: Int) {
        if !(number < 100 && number >= 0) {
            assertionFailure("Number must be a two-digit number")
        }
        self.number = number
    }
}

