import UIKit
import Components

public final class ButtonPayService {
    
    // MARK: - Properties
    
    public private(set) var view: ButtonPay
    public private(set) var viewProperties: ButtonPay.ViewProperties
    public private(set) var style: ButtonPayStyle
    
    // MARK: - Init
    
    public init(
        view: ButtonPay = .init(),
        viewProperties: ButtonPay.ViewProperties = .init(),
        style: ButtonPayStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newType: ButtonPayStyle.`Type`? = nil,
        newText: NSMutableAttributedString? = nil
    ) {
        if let newText {
            viewProperties.text = newText
        }
        
        style.update(
            newType: newType,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
}
