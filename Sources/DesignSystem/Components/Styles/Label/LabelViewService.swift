import UIKit
import Components

public final class LabelViewService {
    public private(set) var view: LabelView
    public private(set) var viewProperties: LabelView.ViewProperties
    public private(set) var style: LabelViewStyle
    
    public init(
        view: LabelView = .init(),
        viewProperties: LabelView.ViewProperties = .init(),
        style: LabelViewStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        
        update()
    }
    
    public func update(
        newVariant: LabelViewStyle.Variant? = nil
    ) {
        style.update(
            variant: newVariant,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
}
