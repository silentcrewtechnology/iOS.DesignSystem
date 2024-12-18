import UIKit
import Components

public final class InputOTPViewStyle {
    
    // MARK: - Properties
    
    public private(set) var state: InputOTPItemViewStyle.State
    
    // MARK: - Init
    
    public init(state: InputOTPItemViewStyle.State) {
        self.state = state
    }
    
    // MARK: - Methods
    
    public func update(
        state: InputOTPItemViewStyle.State? = nil,
        viewProperties: inout InputOTPView.ViewProperties
    ) {
        if let state { self.state = state }
        
        viewProperties.stackSpacing = 8
        viewProperties.hintViewInsets = .init(top: .zero, left: 16, bottom: .zero, right: 16)
        viewProperties.isUserInteractionEnabled = self.isUserInteractionEnabled()
        viewProperties.textFieldViewProperties.text = viewProperties.textFieldViewProperties.text
            .fontStyle(.textM)
            .alignment(.center)
    }
    
    // MARK: - Private methods
    
    private func isUserInteractionEnabled() -> Bool {
        switch state {
        case .disabled: false
        default: true
        }
    }
}
