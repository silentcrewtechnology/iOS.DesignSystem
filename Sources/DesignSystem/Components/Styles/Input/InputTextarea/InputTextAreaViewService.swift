import UIKit
import Components

public final class InputTextAreaViewService {
    
    // MARK: - Properties
    
    public private(set) var view: InputTextAreaView
    public private(set) var viewProperties: InputTextAreaView.ViewProperties
    public private(set) var style: InputTextAreaViewStyle
    public private(set) var labelService = LabelViewService(
        style: .init(variant: .default(customColor: nil))
    )
    public private(set) var hintService = HintViewService(
        style: .init(variant: .right, color: .error)
    )
    
    // MARK: - Private properties
    
    private var onBeginEditing: (String?) -> Void
    private var onEndEditing: (String?) -> Void
    private var onShouldChangeText: (UITextView, NSRange, String) -> Bool
    
    private lazy var delegate: DefaultTextViewDelegate = {
        let delegate = DefaultTextViewDelegate(
            onBeginEditing: { [weak self] text in
                if self?.style.state != .active {
                    self?.update(newState: .active)
                }
                self?.onBeginEditing(text)
            },
            onEndEditing: { [weak self] text in
                self?.update(newState: self?.style.state == .disabled ? .disabled : .default)
                self?.onEndEditing(text)
            },
            onShouldChangeText: { [weak self] textView, range, string in
                guard let self else { return true }
                let currentText = textView.text ?? ""
                let text = (currentText as NSString).replacingCharacters(in: range, with: string)
                viewProperties.textViewProperties.text = text.attributed
                return self.onShouldChangeText(textView, range, string)
            },
            onTextChanged: textChanged
        )
        
        return delegate
    }()
    
    // MARK: - Init
    
    public init(
        view: InputTextAreaView = .init(),
        viewProperties: InputTextAreaView.ViewProperties = .init(),
        style: InputTextAreaViewStyle,
        onBeginEditing: @escaping (String?) -> Void = { _ in },
        onEndEditing: @escaping (String?) -> Void = { _ in },
        onShouldChangeText: @escaping (UITextView, NSRange, String) -> Bool = { _,_,_  in true}
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        self.onBeginEditing = onBeginEditing
        self.onEndEditing = onEndEditing
        self.onShouldChangeText = onShouldChangeText
        
        self.viewProperties.hintView = hintService.view
        self.viewProperties.textViewProperties.delegateAssigningClosure = { [weak self] textView in
            guard let self else { return }
            textView.delegate = self.delegate
        }
        
        changeHintColor(with: style.state)
        changeLabelIsHidden(with: style.label)
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newState: InputTextAreaViewStyle.State? = nil,
        newLabel: InputTextAreaViewStyle.Label? = nil,
        onTextChanged: ((String?) -> Void)? = nil
    ) {
        if let newState {
            changeHintColor(with: newState)
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
    
    private func changeHintColor(with state: InputTextAreaViewStyle.State) {
        switch state {
        case .default: hintService.update(newVariant: .right, newColor: .default)
        case .active: hintService.update(newVariant: .right, newColor: .active)
        case .error: hintService.update(newVariant: .both, newColor: .error)
        case .disabled: hintService.update(newVariant: .right, newColor: .disabled)
        }
    }
    
    private func changeLabelIsHidden(with label: InputTextAreaViewStyle.Label) {
        switch label {
        case .off: viewProperties.headerView = nil
        case .on: viewProperties.headerView = labelService.view
        }
    }
    
    private func textChanged(text: String?) {
        if let text, !text.isEmpty {
            viewProperties.isPlaceholderHidden = true
        } else {
            viewProperties.isPlaceholderHidden = false
        }
        
        update()
        viewProperties.onTextChanged?(text)
    }
}
