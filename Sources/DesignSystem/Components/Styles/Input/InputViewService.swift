import UIKit
import Components

public protocol InputViewServiceProtocol {
    var view: InputView { get }
    var viewProperties: InputView.ViewProperties { get }
    var style: InputViewStyle { get }
    
    init(
        view: InputView,
        viewProperties: InputView.ViewProperties,
        style: InputViewStyle,
        onBeginEditing: @escaping (String?) -> Void,
        onEndEditing: @escaping (String?) -> Void,
        onShouldChangeCharacters: @escaping (UITextField, NSRange, String) -> Bool
    )
    
    func update(
        with parameters: InputViewService.InputUpdateParameters?,
        onTextChanged: ((String?) -> Void)?
    )
}

public final class InputViewService: InputViewServiceProtocol {
    public var onTextChange: ((String) -> Void)?
    
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
                self?.update(state: self?.style.state == .disabled ? .disabled : .default)
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
    
    public struct InputUpdateParameters {
        var state: InputViewStyle.State? = nil
        var set: InputViewStyle.Set? = nil
        var label: InputViewStyle.Label? = nil
        
        public init(
            state: InputViewStyle.State? = nil,
            set: InputViewStyle.Set? = nil,
            label: InputViewStyle.Label? = nil
        ) {
            self.state = state
            self.set = set
            self.label = label
        }
    }
    
    // MARK: - Methods
    
    public func update(
        with parameters: InputUpdateParameters? = nil,
        onTextChanged: ((String?) -> Void)? = nil
    ) {
        if let state = parameters?.state {
            changeHintIsHidden(with: state)
        }
        
        if let label = parameters?.label {
            changeLabelIsHidden(with: label)
        }
        
        if let onTextChanged {
            viewProperties.onTextChanged = onTextChanged
        }
        
        style.update(
            state: parameters?.state,
            set: parameters?.set,
            label: parameters?.label,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
    
    @objc private func textChanged(textField: UITextField) {
        viewProperties.onTextChanged?(textField.text)
    }
}

extension InputViewService {
    @available(*, deprecated, message: "Use  update(with parameters:")
    public func update(
        state: InputViewStyle.State? = nil,
        set: InputViewStyle.Set? = nil,
        label: InputViewStyle.Label? = nil
    ) {
        update(with: .init(
            state: state,
            set: set,
            label: label
        ))
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
    
}
