import Foundation
import UIKit
import Components

public struct StepperItemViewStyle {
    
    public enum State {
        case success
        case active
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
            viewProperties.backgroundColor = .contentAction
        case .active:
            viewProperties.progressViewWidth = 12
            viewProperties.backgroundColor = .backgroundSecondary
        case .next:
            viewProperties.progressViewWidth = 0
            viewProperties.backgroundColor = .backgroundSecondary
        }
        viewProperties.height = 4
        viewProperties.cornerRadius = 2
        viewProperties.progressViewBackgroundColor = .contentAction
    }
}
