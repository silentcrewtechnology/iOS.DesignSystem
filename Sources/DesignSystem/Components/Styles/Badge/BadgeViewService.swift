import UIKit
import Components

public final class BadgeViewService {
    
    // MARK: - Properties
    
    public private(set) var view: BadgeView
    public private(set) var viewProperties: BadgeView.ViewProperties
    public private(set) var style: BadgeStyle
    
    // MARK: - Init
    
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
    
    // MARK: - Methods
    
    public func update(
        newColor: BadgeStyle.Color? = nil,
        newSize: BadgeStyle.Size? = nil,
        newSet: BadgeStyle.Set? = nil,
        newText: NSMutableAttributedString? = nil
    ) {
        if let newText {
            viewProperties.text = newText
        }
        
        style.update(
            newColor: newColor,
            newSize: newSize,
            newSet: newSet,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
}
