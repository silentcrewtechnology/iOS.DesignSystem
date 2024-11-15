import UIKit
import Components

public final class BannerViewService {
    
    // MARK: - Properties
    
    public private(set) var view: BannerView
    public private(set) var viewProperties: BannerView.ViewProperties
    public private(set) var style: BannerViewStyle
    
    // MARK: - Init
    
    public init(
        view: BannerView = .init(),
        viewProperties: BannerView.ViewProperties = .init(),
        style: BannerViewStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newVariant: BannerViewStyle.Variant? = nil,
        newTitle: NSMutableAttributedString? = nil,
        newSubtitle: NSMutableAttributedString? = nil,
        newBottomButton: BannerView.ViewProperties.BottomButton? = nil
    ) {
        if let newTitle {
            viewProperties.title = newTitle
        }
        
        if let newSubtitle {
            viewProperties.subtitle = newSubtitle
        }
        
        if let newBottomButton {
            viewProperties.bottomButton = newBottomButton
        }
        
        style.update(
            newVariant: newVariant,
            with: &viewProperties
        )
        view.update(with: viewProperties)
    }
}
