import UIKit
import Components

public final class HintViewService {
    public private(set) var view: HintView
    public private(set) var viewProperties: HintView.ViewProperties
    public private(set) var style: HintViewStyle
    
    public init(
        view: HintView = .init(),
        viewProperties: HintView.ViewProperties = .init(),
        style: HintViewStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        
        update()
    }
    
    public func update(
        newVariant: HintViewStyle.Variant? = nil,
        newColor: HintViewStyle.Color? = nil
    ) {
        style.update(
            variant: newVariant,
            color: newColor,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
}
