import UIKit
import Components

public final class InputSelectViewService {
    
    // MARK: - Properties
    
    public private(set) var view: InputSelectView
    public private(set) var viewProperties: InputSelectView.ViewProperties
    public private(set) var style: InputSelectViewStyle
    public private(set) var labelService = LabelViewService(
        style: .init(variant: .default(customColor: nil))
    )
    public private(set) var hintService = HintViewService(
        style: .init(variant: .left, color: .error)
    )
    
    // MARK: - Private properties
    
    private var textField: UITextField?
    private var onBeginEditing: (UITextField) -> Void
    private var onEndEditing: (UITextField) -> Void
    private var onShouldChangeCharacters: (UITextField, NSRange, String) -> Bool
   
    private lazy var delegate: DefaultTextFieldDelegate = {
        let delegate = DefaultTextFieldDelegate(
            onBeginEditing: { [weak self] textField in
                if self?.style.state != .active {
                    self?.update(newState: .active)
                }
                self?.onBeginEditing(textField)
            },
            onEndEditing: { [weak self] textField in
                self?.update(newState: self?.style.state == .disabled ? .disabled : .default)
                self?.onEndEditing(textField)
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
        view: InputSelectView = .init(),
        viewProperties: InputSelectView.ViewProperties = .init(),
        style: InputSelectViewStyle,
        onBeginEditing: @escaping (UITextField) -> Void = { _ in },
        onEndEditing: @escaping (UITextField) -> Void = { _ in },
        onShouldChangeCharacters: @escaping (UITextField, NSRange, String) -> Bool = { _,_,_  in true}
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        self.onBeginEditing = onBeginEditing
        self.onEndEditing = onEndEditing
        self.onShouldChangeCharacters = onShouldChangeCharacters
        
        self.viewProperties.hintView = hintService.view
        self.viewProperties.onClear = { [weak self] in
            self?.textField?.text?.removeAll()
            self?.viewProperties.textFieldViewProperties.text = .init()
            self?.update()
        }
        self.viewProperties.textFieldViewProperties.delegateAssigningClosure = { [weak self] textField in
            guard let self else { return }
            self.textField = textField
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
        newState: InputSelectViewStyle.State? = nil,
        newLabel: InputSelectViewStyle.Label? = nil,
        onTextChanged: ((String?) -> Void)? = nil
    ) {
        if let newState {
            changeHintIsHidden(with: newState)
        }
        
        if let newLabel {
            changeLabelIsHidden(with: newLabel)
        }
        
        if let onTextChanged {
            viewProperties.onTextChanged = onTextChanged
        }
        
        style.update(
            newState: newState,
            newLabel: newLabel,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
    
    // MARK: - Private methods
    
    private func changeHintIsHidden(with state: InputSelectViewStyle.State) {
        switch state {
        case .error:
            hintService.update(newVariant: .left, newColor: .error)
        default:
            hintService.update(newVariant: .empty)
        }
    }
    
    private func changeLabelIsHidden(with label: InputSelectViewStyle.Label) {
        switch label {
        case .off:
            viewProperties.headerView = nil
        case .on:
            viewProperties.headerView = labelService.view
        }
    }
    
    @objc private func textChanged(textField: UITextField) {
        viewProperties.onTextChanged?(textField.text)
        update() // Для обновления clearButton.isHidden
    }
}
