import UIKit
import Components

public final class StepperItemViewStyle {
    
    // MARK: - Properties
    
    public enum State {
        case success
        case current
        case next
    }
    
    // MARK: - Private properties
    
    private var state: State
    
    // MARK: - Init
    
    public init(state: State) {
        self.state = state
    }
    
    // MARK: - Methods
    
    public func update(
        state: State?,
        viewProperties: inout StepperItemView.ViewProperties
    ) {
        if let state {
            self.state = state
        }

        viewProperties.backgroundColor = .Components.StepperItem.Background.Color.default
        viewProperties.progressViewBackgroundColor = .Components.StepperItem.Value.Color.default
        viewProperties.progressViewWidth = self.state.progressViewWidth()
        viewProperties.shouldStretchProgressView = self.state == .success
        viewProperties.height = 4
        viewProperties.cornerRadius = 2
    }
}

// MARK: - StepperItemViewStyle.State Extension

public extension StepperItemViewStyle.State {
    
    func progressViewWidth() -> CGFloat {
        switch self {
        case .success, .next:.zero
        case .current: 12
        }
    }
}
