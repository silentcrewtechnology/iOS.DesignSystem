import UIKit
import Colors
import Components

public final class StepperViewStyle {
    
    // MARK: - Init
    
    public init() { }
    
    // MARK: - Methods
    
    public func update(
        viewProperties: inout StepperView.ViewProperties
    ) {
        viewProperties.stackViewInsets = .init(top: .zero, left: 16, bottom: .zero, right: 16)
        viewProperties.stackViewSpacing = 4
    }
}
