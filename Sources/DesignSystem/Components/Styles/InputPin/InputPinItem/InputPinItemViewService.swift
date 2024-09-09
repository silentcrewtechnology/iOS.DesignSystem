import UIKit
import Components

public final class InputPinItemViewService {
    
    public typealias V = InputPinItemView
    public typealias Style = InputPinItemViewStyle
    
    public private(set) var view: V
    public private(set) var viewProperties: V.ViewProperties
    public private(set) var style: Style
    
    public init(
        view: V = .init(),
        viewProperties: V.ViewProperties = .init(),
        style: Style = .init()
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        update()
    }
    
    public func update(
        state: Style.State? = nil
    ) {
        style.update(
            state: state,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
}
