import UIKit
import Components

public final class TitleViewService {
    
    // MARK: - Properties
    
    public private(set) var view: TitleView
    public private(set) var viewProperties: TitleView.ViewProperties
    public private(set) var style: TitleViewStyle
    public private(set) var buttonIconService: ButtonIconService?
    
    // MARK: - Init
    
    public init(
        view: TitleView = .init(),
        viewProperties: TitleView.ViewProperties = .init(),
        style: TitleViewStyle,
        buttonIconService: ButtonIconService? = nil
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        
        setupButtonIcon(using: buttonIconService)
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newSize: TitleViewStyle.Size? = nil,
        newTitle: NSMutableAttributedString? = nil,
        newTitleColor: TitleViewStyle.Color? = nil,
        newDescription: NSMutableAttributedString? = nil,
        showButton: Bool? = nil,
        newButtonIconService: ButtonIconService? = nil
    ) {
        if let newTitle { viewProperties.title = newTitle }
        if let newDescription { viewProperties.description = newDescription }
        if let newButtonIconService { setupButtonIcon(using: newButtonIconService) }
        if let showButton { viewProperties.buttonIcon.isHidden = !showButton }
        style.update(
            newSize: newSize,
            newTitleColor: newTitleColor,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
    
    /// Подставляем пустую скрытую вьюху вместо `buttonIcon`, если `buttonIconService == nil`
    private func setupButtonIcon(using buttonIconService: ButtonIconService?) {
        self.buttonIconService = buttonIconService
        guard let buttonIconService else {
            viewProperties.buttonIcon = .init()
            viewProperties.buttonIcon.isHidden = true
            return
        }
        viewProperties.buttonIcon = buttonIconService.view
        buttonIconService.update(newSize: style.buttonIconSize())
    }
}
