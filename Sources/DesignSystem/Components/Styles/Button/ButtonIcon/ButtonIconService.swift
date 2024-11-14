import UIKit
import Components

public final class ButtonIconService {
    
    // MARK: - Properties
    
    public private(set) var view: ButtonIcon
    public private(set) var viewProperties: ButtonIcon.ViewProperties
    public private(set) var style: ButtonIconStyle
    public private(set) var loaderService: LoaderViewService = .init(
        style: .init(color: .main, size: .s)
    )
    
    // MARK: - Init
    
    public init(
        view: ButtonIcon = .init(),
        viewProperties: ButtonIcon.ViewProperties = .init(),
        style: ButtonIconStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        
        self.viewProperties.loader = loaderService.view
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newSize: ButtonIconStyle.Size? = nil,
        newColor: ButtonIconStyle.Color? = nil,
        newVariant: ButtonIconStyle.Variant? = nil,
        newState: ButtonIconStyle.State? = nil
    ) {
        style.update(
            variant: newVariant,
            size: newSize,
            state: newState,
            color: newColor,
            viewProperties: &viewProperties
        )
        loaderService.update(
            newStyle: style.loaderStyle(),
            isHidden: {
                guard let newState else { return loaderService.viewProperties.isHidden }
                return newState != .loading
            }()
        )
        view.update(with: viewProperties)
    }
}
