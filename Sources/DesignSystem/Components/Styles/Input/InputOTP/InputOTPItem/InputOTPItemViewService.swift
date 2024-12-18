import UIKit
import Components

public final class InputOTPItemViewService {
    
    // MARK: - Properties
    
    public private(set) var view: InputOTPItemView
    public private(set) var viewProperties: InputOTPItemView.ViewProperties
    public private(set) var style: InputOTPItemViewStyle
    
    // MARK: - Init
    
    public init(
        view: InputOTPItemView = .init(),
        viewProperties: InputOTPItemView.ViewProperties = .init(),
        style: InputOTPItemViewStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newState: InputOTPItemViewStyle.State? = nil,
        newText: NSMutableAttributedString? = nil
    ) {
        if let newText { viewProperties.text = newText }
        
        style.update(
            state: newState,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
}
