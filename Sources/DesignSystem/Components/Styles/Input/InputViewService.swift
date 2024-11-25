import UIKit
import Components

public final class InputViewService {
    
    // MARK: - Properties
    
    public private(set) var view: InputView
    public private(set) var viewProperties: InputView.ViewProperties
    public private(set) var style: InputViewStyle
    public private(set) var labelService = LabelViewService(
        style: .init(variant: .default(customColor: nil))
    )
    public private(set) var hintService = HintViewService(
        style: .init(variant: .left, color: .error)
    )
    
    // MARK: - Private properties
    
    private var onBeginEditing: (String?) -> Void
    private var onEndEditing: (String?) -> Void
    private var onShouldChangeCharacters: (UITextField, NSRange, String) -> Bool
    
    private lazy var delegate: DefaultTextFieldDelegate = {
        let delegate = DefaultTextFieldDelegate(
            onBeginEditing: { [weak self] text in
                if self?.style.state != .active {
                    self?.update(state: .active)
                }
                
                self?.onBeginEditing(text)
            },
            onEndEditing: { [weak self] text in
                self?.update(state: .default)
                self?.onEndEditing(text)
            },
            onShouldChangeCharacters: { [weak self] textField, range, string in
                guard let self else { return true }
                let currentText = textField.text ?? ""
                let text = (currentText as NSString).replacingCharacters(in: range, with: string)
                viewProperties.textFieldViewProperties.text = text.attributed
                return self.onShouldChangeCharacters(textField, range, string)
            }
        )
        
        return delegate
    }()
    
    // MARK: - Init
    
    public init(
        view: InputView = .init(),
        viewProperties: InputView.ViewProperties = .init(),
        style: InputViewStyle,
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
        
        self.viewProperties.hintView = hintService.view
        self.viewProperties.textFieldViewProperties.delegateAssigningClosure = { [weak self] textField in
            guard let self else { return }
            textField.delegate = self.delegate
            textField.addTarget(
                self,
                action: #selector(self.textChanged(textField:)),
                for: .editingChanged
            )
        }
        
        changeHintIsHidden(with: style.state)
        changeLabelIsHidden(with: style.label)
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        state: InputViewStyle.State? = nil,
        set: InputViewStyle.Set? = nil,
        label: InputViewStyle.Label? = nil,
        onTextChanged: ((String?) -> Void)? = nil
    ) {
        if let state {
            changeHintIsHidden(with: state)
        }
        
        if let label {
            changeLabelIsHidden(with: label)
        }
        
        if let onTextChanged {
            viewProperties.onTextChanged = onTextChanged
        }
        
        style.update(
            state: state,
            set: set,
            label: label,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
    
    // MARK: - Private methods
    
    private func changeHintIsHidden(with state: InputViewStyle.State) {
        switch state {
        case .error:
            hintService.update(newVariant: .left, newColor: .error)
        default:
            hintService.update(newVariant: .empty)
        }
    }
    
    private func changeLabelIsHidden(with label: InputViewStyle.Label) {
        switch label {
        case .off:
            viewProperties.headerView = nil
        case .on:
            viewProperties.headerView = labelService.view
        }
    }
    
    @objc private func textChanged(textField: UITextField) {
        viewProperties.onTextChanged?(textField.text)
    }
}
