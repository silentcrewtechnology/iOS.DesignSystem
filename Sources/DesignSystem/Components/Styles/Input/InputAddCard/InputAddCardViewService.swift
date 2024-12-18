import UIKit
import Components

public final class InputAddCardViewService: NSObject {
    
    public typealias V = InputAddCardView
    public typealias Style = InputAddCardViewStyle
    
    // MARK: - Properties
    
    public private(set) var view: V
    public private(set) var viewProperties: V.ViewProperties
    public private(set) var style: Style
    public private(set) var cardViewService: CardViewService = .init(style: .init(set: .empty, size: .small, stack: .false))
    public private(set) var cardNumberHintedFieldService: InputAddCardHintedFieldService
    public private(set) var buttonIconService: ButtonIconService?
    public private(set) var dateHintedFieldService: InputAddCardHintedFieldService
    
    // MARK: - Init
    
    public init(
        view: V = .init(),
        viewProperties: V.ViewProperties = .init(),
        style: Style = .init(),
        cardNumberHintedFieldService: InputAddCardHintedFieldService,
        buttonIconService: ButtonIconService? = nil,
        dateHintedFieldService: InputAddCardHintedFieldService
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        self.cardNumberHintedFieldService = cardNumberHintedFieldService
        self.dateHintedFieldService = dateHintedFieldService
        self.buttonIconService = buttonIconService
        super.init()
        setupView()
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newState: Style.State? = nil,
        newButtonIconService: ButtonIconService? = nil
    ) {
        if let newButtonIconService { setupButtonIcon(using: newButtonIconService) }
        style.update(
            state: newState,
            viewProperties: &viewProperties
        )
        cardViewService.view.alpha = style.cardViewOpacity()
        cardNumberHintedFieldService.update(newState: style.textFieldState())
        dateHintedFieldService.update(newState: style.textFieldState())
        view.update(with: viewProperties)
        buttonIconService?.update(newState: style.buttonIconState())
    }
    
    private func setupView() {
        viewProperties.cardView = cardViewService.view
        viewProperties.numberHintedField = cardNumberHintedFieldService.view
        viewProperties.dateHintedField = dateHintedFieldService.view
        dateHintedFieldService.view.isHidden = true
        setupButtonIcon(using: buttonIconService)
        viewProperties.buttonIcon = buttonIconService?.view
    }
    
    private func setupButtonIcon(using buttonIconService: ButtonIconService?) {
        self.buttonIconService = buttonIconService
        guard let buttonIconService else { return }
        viewProperties.buttonIcon = buttonIconService.view
        buttonIconService.update(
            newSize: style.buttonIconSize(),
            newState: style.buttonIconState()
        )
    }
}
