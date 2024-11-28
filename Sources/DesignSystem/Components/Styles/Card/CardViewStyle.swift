import UIKit
import Components
import Colors
import ImagesService

public final class CardViewStyle {
    
    // MARK: - Properties
    
    public enum Set {
        case add
        case empty
        case visa
        case mir
        case mastercard
    }

    public enum Size {
        case small
        case medium
    }
    
    public enum Stack {
        case `false`
        case `true`(CardView.ViewProperties)
    }
    
    // MARK: - Private properties
    
    private var set: Set
    private var size: Size
    private var stack: Stack
    
    // MARK: - Life cycle
    
    public init(
        set: Set,
        size: Size,
        stack: Stack
    ) {
        self.set = set
        self.size = size
        self.stack = stack
    }
    
    // MARK: - Methods
    
    public func update(
        viewProperties: inout CardView.ViewProperties,
        backgroundImage: UIImage? = nil,
        maskedCardNumber: NSMutableAttributedString? = nil,
        newSet: Set? = nil,
        newSize: Size? = nil,
        newStack: Stack? = nil
    ) {
        if let newSet {
            self.set = newSet
        }
        
        if let newSize {
            self.size = newSize
        }
        
        if let newStack {
            self.stack = newStack
        }
        
        viewProperties.size = size.size()
        viewProperties.cornerRadius = size.cornerRadius()
        viewProperties.containerInsets = size.insets()
        viewProperties.paymentSystemImageInsets = size.paymentSystemInsets()
        viewProperties.paymentSystemImage = set.paymentSystemImage()
        viewProperties.paymentSystemImageSize = .init(width: 24, height: 24)
        viewProperties.centerImage = set.centerImage()
        viewProperties.backgroundColor = set.backgroundColor()
        viewProperties.backgroundImage = backgroundImage
        viewProperties.maskedCardNumberLabelInsets = size.cardNumberInsets()
        viewProperties.gradientViewProperties = .init(
            endPoint: .init(x: .zero, y: 1),
            colors: [
                UIColor.black.withAlphaComponent(0).cgColor,
                UIColor.black.withAlphaComponent(0.25).cgColor
            ],
            insets: .init(top: 14, left: .zero, bottom: .zero, right: .zero)
        )
        viewProperties.maskedCardNumber = maskedCardNumber?
            .fontStyle(.text3XS_1)
            .foregroundColor(.Semantic.LightTheme.Content.Base.accentOn)
        viewProperties.isMaskedCardNumberHidden = self.size == .small
        
        if set == .empty {
            viewProperties.emptyBand = .init(
                backgroundColor: .Semantic.LightTheme.Static.blackGray,
                topInset: size.emptyBandTopInset(),
                height: size.emptyBandHeight()
            )
        } else {
            viewProperties.emptyBand = nil
        }
    }
    
    public func stackCardSize() -> CGSize {
        switch size {
        case .small: .init(width: 36, height: 23)
        case .medium: .init(width: 44, height: 28)
        }
    }
    
    public func stackCardInsets() -> UIEdgeInsets {
        switch size {
        case .small: .init(top: .zero, left: .zero, bottom: -2, right: .zero)
        case .medium: .init(top: .zero, left: .zero, bottom: -3, right: .zero)
        }
    }
    
    public func stackCardCornerRadius() -> CGFloat {
        switch size {
        case .small: 2
        case .medium: 4
        }
    }
}

// MARK: - CardViewStyle.Set Extension

public extension CardViewStyle.Set {
    
    func paymentSystemImage() -> UIImage? {
        switch self {
        case .visa: .brand40VisaWhite
        case .mir: .brand40MirWhite
        case .mastercard: .brand40Mastercard
        default: nil
        }
    }
    
    func centerImage() -> UIImage? {
        switch self {
        case .add: .ic16Plus.withTintColor(.Semantic.LightTheme.Content.Base.secondary)
        default: nil
        }
    }
    
    func backgroundColor() -> UIColor? {
        switch self {
        case .add, .empty: .Semantic.LightTheme.Background.Base.secondary
        default: nil
        }
    }
}

// MARK: - CardViewStyle.Size Extension

public extension CardViewStyle.Size {
    
    func size() -> CGSize {
        switch self {
        case .small: .init(width: 40, height: 40)
        case .medium: .init(width: 50, height: 40)
        }
    }
    
    func cornerRadius() -> CGFloat {
        switch self {
        case .small: 4
        case .medium: 5
        }
    }
    
    func insets() -> UIEdgeInsets {
        switch self {
        case .small: .init(top: 7, left: .zero, bottom: 7, right: .zero)
        case .medium: .init(top: 4, left: .zero, bottom: 4, right: .zero)
        }
    }
    
    func emptyBandTopInset() -> CGFloat {
        switch self {
        case .small: 6
        case .medium: 8
        }
    }
    
    func emptyBandHeight() -> CGFloat {
        switch self {
        case .small: 6
        case .medium: 8
        }
    }
    
    func paymentSystemInsets() -> UIEdgeInsets {
        switch self {
        case .small: .init(top: 6, left: .zero, bottom: .zero, right: 2)
        case .medium: .init(top: .zero, left: 2, bottom: 12, right: .zero)
        }
    }
    
    func cardNumberInsets() -> UIEdgeInsets {
        switch self {
        case .small: .zero
        case .medium: .init(top: .zero, left: 4, bottom: .zero, right: .zero)
        }
    }
}
