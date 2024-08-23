import UIKit
import Components

public final class InputViewService {
    public private(set) var view: InputView
    public private(set) var viewProperties: InputView.ViewProperties
    public private(set) var style: InputViewStyle
    
    public init(
        view: InputView = .init(),
        viewProperties: InputView.ViewProperties = .init(),
        style: InputViewStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
    }
    
    
    public func update(
        state: InputViewStyle.State? = nil,
        set: InputViewStyle.Set? = nil
    ) {
        style.update(
            state: state,
            set: set,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
}
