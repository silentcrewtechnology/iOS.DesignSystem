import UIKit
import Components

public final class InputPinItemViewService {
    
    // MARK: - Properties
    
    public typealias V = InputPinItemView
    public typealias Style = InputPinItemViewStyle
    
    public private(set) var view: V
    public private(set) var viewProperties: V.ViewProperties
    public private(set) var style: Style
    
    // MARK: - Init
    
    public init(
        view: V = .init(),
        viewProperties: V.ViewProperties = .init(),
        style: Style = .init()
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        variant: Style.Variant? = nil
    ) {
        style.update(
            variant: variant,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
}
