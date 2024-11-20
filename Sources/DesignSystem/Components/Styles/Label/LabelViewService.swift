import UIKit
import Components

public final class LabelViewService {
    
    // MARK: - Properties
    
    public private(set) var view: LabelView
    public private(set) var viewProperties: LabelView.ViewProperties
    public private(set) var style: LabelViewStyle
    
    // MARK: - Init
    
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
    
    // MARK: - Methods
    
    public func update(
        newVariant: LabelViewStyle.Variant? = nil,
        newText: NSMutableAttributedString? = nil
    ) {
        if let newText {
            viewProperties.text = newText
        }
        
        style.update(
            variant: newVariant,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
}
