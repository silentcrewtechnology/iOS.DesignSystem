import UIKit
import Components

public final class ButtonAuthService {
    
    // MARK: - Properties
    
    public private(set) var view: ButtonAuth
    public private(set) var viewProperties: ButtonAuth.ViewProperties
    public private(set) var style: ButtonAuthStyle
    
    // MARK: - Init
    
    public init(
        view: ButtonAuth = .init(),
        viewProperties: ButtonAuth.ViewProperties = .init(),
        style: ButtonAuthStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        
        configureOnHighligthed()
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newVariant: ButtonAuthStyle.Variant? = nil,
        newState: ButtonAuthStyle.State? = nil,
        newColor: ButtonAuthStyle.Color? = nil,
        newText: NSMutableAttributedString? = nil,
        newImage: UIImage? = nil
    ) {
        if let newText {
            viewProperties.text = newText
        }
        
        if let newImage {
            viewProperties.image = newImage
        }
        
        style.update(
            variant: newVariant,
            state: newState,
            color: newColor,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
    
    // MARK: - Private methods
    
    private func configureOnHighligthed() {
        viewProperties.onHighlighted = { [weak self] isHighlighted in
            self?.update(newState: isHighlighted ? .pressed : .default)
        }
    }
}
