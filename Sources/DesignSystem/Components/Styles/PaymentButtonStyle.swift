import UIKit
import Components
import Colors

public struct PaymentButtonStyle {
    
    public init() { }
    
    public func update(viewProperties: inout PaymentButton.ViewProperties) {
        viewProperties.height = 56
        viewProperties.backgroundColor = .backgroundMainInverse
        viewProperties.cornerRadius = 8
        viewProperties.text = viewProperties.text
            .fontStyle(.textM)
            .foregroundColor(tintColor())
    }
    
    public func tintColor() -> UIColor { .contentActionOn }
}
