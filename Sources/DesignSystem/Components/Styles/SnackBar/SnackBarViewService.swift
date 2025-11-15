import UIKit
import Components

public final class SnackBarViewService {
    
    // MARK: - Properties
    
    public private(set) var view: SnackBarView
    public private(set) var viewProperties: SnackBarView.ViewProperties
    public private(set) var style: SnackBarViewStyle
    private var isAnimating = false
    
    // MARK: - Init
    
    public init(
        view: SnackBarView = .init(),
        viewProperties: SnackBarView.ViewProperties = .init(),
        style: SnackBarViewStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
    
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newVariant: SnackBarViewStyle.Variant? = nil,
        newDelay: SnackBarViewStyle.Delay? = nil,
        newTitle: NSMutableAttributedString? = nil,
        newSubtitle: NSMutableAttributedString? = nil,
        newBottomButtonText: NSMutableAttributedString? = nil
    ) {
        if let newTitle { viewProperties.title = newTitle }
        
        if let newSubtitle { viewProperties.subtitle = newSubtitle }
        
        if let newBottomButtonText { viewProperties.bottomButton?.title = newBottomButtonText }
        
        style.update(
            newVariant: newVariant,
            newDelay: newDelay,
            viewProperties: &viewProperties
        )
        viewProperties.animationOut.completion = { [weak self] in self?.isAnimating = false }
        view.update(with: viewProperties)
    }
    
    public func show(on view: UIView) {
        guard !isAnimating else { return }
        
        isAnimating = true
        self.view.show(on: view)
    }
    
    public func hide() {
        guard isAnimating else { return }
        
        isAnimating = false
        view.hide()
    }
}
