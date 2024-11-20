import UIKit
import Components

public final class HintViewService {
    
    // MARK: - Properties
    
    public private(set) var view: HintView
    public private(set) var viewProperties: HintView.ViewProperties
    public private(set) var style: HintViewStyle
    
    // MARK: - Init
    
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
    
    // MARK: - Methods
    
    public func update(
        newVariant: HintViewStyle.Variant? = nil,
        newColor: HintViewStyle.Color? = nil,
        newText: NSMutableAttributedString? = nil,
        newAdditionalText: NSMutableAttributedString? = nil
    ) {
        if let newText {
            viewProperties.text = newText
        }
        
        if let newAdditionalText {
            viewProperties.additionalText = newAdditionalText
        }
        
        style.update(
            variant: newVariant,
            color: newColor,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
}
