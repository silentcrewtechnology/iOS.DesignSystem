import UIKit
import Components

public final class BadgeViewService {
    public private(set) var view: BadgeView
    public private(set) var viewProperties: BadgeView.ViewProperties
    public private(set) var style: BadgeStyle
    
    public init(
        view: BadgeView = .init(),
        viewProperties: BadgeView.ViewProperties = .init(),
        style: BadgeStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        
        update()
    }
    
    public func update(
        newColor: BadgeStyle.Color? = nil,
        newSize: BadgeStyle.Size? = nil,
        newSet: BadgeStyle.Set? = nil
    ) {
        style.update(
            newColor: newColor,
            newSize: newSize,
            newSet: newSet,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
}
