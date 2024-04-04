import Foundation
import Components

public struct HintViewStyle {
    
    public enum Variant {
        case empty
        case left(NSMutableAttributedString)
        case right(NSMutableAttributedString)
        case both(NSMutableAttributedString, NSMutableAttributedString)
    }
    
    public func update(
        variant: Variant,
        viewProperties: inout HintView.ViewProperties
    ) {
        let (leftText, rightText) = variant.texts()
        viewProperties.leftText = leftText?.fontStyle(.text2XS).alignment(.left)
        viewProperties.rightText = rightText?.fontStyle(.text2XS).alignment(.right)
        viewProperties.minHeight = 24
    }
}

public extension HintViewStyle.Variant {
    
    func texts() -> (left: NSMutableAttributedString?, right: NSMutableAttributedString?) {
        switch self {
        case .empty: (nil, nil)
        case .left(let left): (left, nil)
        case .right(let right): (nil, right)
        case .both(let left, let right): (left, right)
        }
    }
}
