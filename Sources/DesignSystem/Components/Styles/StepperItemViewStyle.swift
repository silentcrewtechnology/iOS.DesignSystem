import UIKit
import Components

public struct StepperItemViewStyle {
    
    public enum State {
        case success
        case current
        case next
    }
    
    public init() { }
    
    public func update(
        state: State,
        viewProperties: inout StepperItemView.ViewProperties
    ) {
        switch state {
        case .success:
            viewProperties.progressViewWidth = 0
            viewProperties.backgroundColor = .Components.StepperItem.Value.Color.default
        case .current:
            viewProperties.progressViewWidth = 12
            viewProperties.backgroundColor = .Components.StepperItem.Background.Color.default
        case .next:
            viewProperties.progressViewWidth = 0
            viewProperties.backgroundColor = .Components.StepperItem.Background.Color.default
        }
        viewProperties.height = 4
        viewProperties.cornerRadius = 2
        viewProperties.progressViewBackgroundColor = .Components.StepperItem.Value.Color.default
    }
}
