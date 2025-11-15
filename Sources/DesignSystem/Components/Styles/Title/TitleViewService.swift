import UIKit
import Components


public protocol TitleViewServiceProtocol {
    var view: TitleView { get }
    var viewProperties: TitleView.ViewProperties { get }
    var style: TitleViewStyle { get }
    var buttonIconService: ButtonIconService? { get }
    
    func update(
        with parameters: TitleViewService.TitleUpdateParameters?
    )
}

public final class TitleViewService: TitleViewServiceProtocol {
    
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
    
    // MARK: - UpdateParameters
    
    public struct TitleUpdateParameters {
        public var newSize: TitleViewStyle.Size?
        public var newTitle: NSMutableAttributedString?
        public var newTitleColor: TitleViewStyle.Color?
        public var newDescription: NSMutableAttributedString?
        public var showButton: Bool?
        public var newButtonIconService: ButtonIconService?
        
        public init(
            newSize: TitleViewStyle.Size? = nil,
            newTitle: NSMutableAttributedString? = nil,
            newTitleColor: TitleViewStyle.Color? = nil,
            newDescription: NSMutableAttributedString? = nil,
            showButton: Bool? = nil,
            newButtonIconService: ButtonIconService? = nil
        ) {
            self.newSize = newSize
            self.newTitle = newTitle
            self.newTitleColor = newTitleColor
            self.newDescription = newDescription
            self.showButton = showButton
            self.newButtonIconService = newButtonIconService
        }
    }
    
    // MARK: - Methods
    
    public func update(
        with parameters: TitleUpdateParameters? = nil
    ) {
        if let newTitle = parameters?.newTitle {
            viewProperties.title = newTitle
        }
        if let newDescription = parameters?.newDescription {
            viewProperties.description = newDescription
        }
        if let newButtonIconService = parameters?.newButtonIconService {
            setupButtonIcon(using: newButtonIconService)
        }
        if let showButton = parameters?.showButton {
            viewProperties.buttonIcon.isHidden = !showButton
        }
        
        style.update(
            newSize: parameters?.newSize,
            newTitleColor: parameters?.newTitleColor,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
    
    // MARK: - Private methods
    
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

extension TitleViewService {
    @available(*, deprecated, message: "Use  update(with parameters:")
    public func update(
        newSize: TitleViewStyle.Size? = nil,
        newTitle: NSMutableAttributedString? = nil,
        newTitleColor: TitleViewStyle.Color? = nil,
        newDescription: NSMutableAttributedString? = nil,
        showButton: Bool? = nil,
        newButtonIconService: ButtonIconService? = nil
    ) {
        update(with: .init(
            newSize: newSize,
            newTitle: newTitle,
            newTitleColor: newTitleColor,
            newDescription: newDescription,
            showButton: showButton,
            newButtonIconService: newButtonIconService
        ))
    }
}
