import UIKit
import Components

public final class DividerViewService {
    
    // MARK: - Properties
    
    public private(set) var view: DividerView
    public private(set) var viewProperties: DividerView.ViewProperties
    public private(set) var style: DividerViewStyle
    
    // MARK: - Init
    
    public init(
        view: DividerView = .init(),
        viewProperties: DividerView.ViewProperties = .init(),
        style: DividerViewStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        variant: DividerViewStyle.Variant? = nil,
        style: DividerViewStyle.Style? = nil
    ) {
        self.style.update(
            variant: variant,
            style: style,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
}
