import UIKit
import Components

public final class StepperItemViewService {
    
    // MARK: - Properties
    
    public private(set) var view: StepperItemView
    public private(set) var viewProperties: StepperItemView.ViewProperties
    public private(set) var style: StepperItemViewStyle
    
    // MARK: - Init
    
    public init(
        view: StepperItemView = .init(),
        viewProperties: StepperItemView.ViewProperties = .init(),
        style: StepperItemViewStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newState: StepperItemViewStyle.State? = nil
    ) {
        style.update(
            state: newState,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
}
