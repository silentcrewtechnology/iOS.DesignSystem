import UIKit
import Components

public final class InputAmountViewService {
    
    // MARK: - Properties
    
    public private(set) var view: InputAmountView
    public private(set) var viewProperties: InputAmountView.ViewProperties
    public private(set) var style: InputAmountViewStyle
    public private(set) var labelService = LabelViewService(
        style: .init(variant: .default(customColor: nil))
    )
    public private(set) var hintService = HintViewService(
        style: .init(variant: .left, color: .default)
    )
    
    // MARK: - Private properties
    
    private var onBeginEditing: (String?) -> Void
    private var onEndEditing: (String?) -> Void
    private var onShouldChangeCharacters: (UITextField, NSRange, String) -> Bool
    
    private lazy var delegate: InputAmountViewTextFieldDelegate = {
        let delegate = InputAmountViewTextFieldDelegate(
            onBeginEditing: { [weak self] text in self?.onBeginEditing(text) },
            onEndEditing: { [weak self] text in self?.onEndEditing(text) },
            onShouldChangeCharacters: { [weak self] textField, range, string in
                guard let self else { return true }
                let currentText = textField.text ?? ""
                let text = (currentText as NSString).replacingCharacters(in: range, with: string)
                viewProperties.textFieldProperties.text = text.attributed
                return self.onShouldChangeCharacters(textField, range, string)
            }
        )
        
        return delegate
    }()
    
    // MARK: - Init
    
    public init(
        view: InputAmountView = .init(),
        viewProperties: InputAmountView.ViewProperties = .init(),
        style: InputAmountViewStyle,
        onBeginEditing: @escaping (String?) -> Void = { _ in },
        onEndEditing: @escaping (String?) -> Void = { _ in },
        onShouldChangeCharacters: @escaping (UITextField, NSRange, String) -> Bool = { _,_,_  in true}
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        self.onBeginEditing = onBeginEditing
        self.onEndEditing = onEndEditing
        self.onShouldChangeCharacters = onShouldChangeCharacters
        
        self.viewProperties.headerView = labelService.view
        self.viewProperties.hintView = hintService.view
        self.viewProperties.textFieldProperties.delegateAssigningClosure = { textField in
            textField.delegate = self.delegate
        }
        
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newState: InputAmountViewStyle.State? = nil
    ) {
        if let newState {
            changeHintColor(with: newState)
        }
        
        style.update(
            state: newState,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
    
    // MARK: - Private methods
    
    private func changeHintColor(with state: InputAmountViewStyle.State) {
        switch state {
        case .default: hintService.update(newColor: .default)
        case .active: hintService.update(newColor: .active)
        case .error: hintService.update(newColor: .error)
        case .disabled: hintService.update(newColor: .disabled)
        }
    }
}
