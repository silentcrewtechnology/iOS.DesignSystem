import UIKit
import Components

public final class InputAmountViewService {
    public private(set) var view: InputAmountView
    public var viewProperties: InputAmountView.ViewProperties
    public private(set) var style: InputAmountViewStyle
    
    public private(set) var headerStyle: LabelViewStyle
    public private(set) var hintStyle: HintViewStyle
    
    private var onBeginEditing: (String?) -> Void
    private var onEndEditing: (String?) -> Void
    private var onShouldChangeCharacters: (UITextField, NSRange, String) -> Bool
    
    private lazy var delegate: InputAmountViewTextFieldDelegate = {
        let delegate = InputAmountViewTextFieldDelegate(
            onBeginEditing: { [weak self] text in
                guard let self else { return }
                self.onBeginEditing(text)
            },
            onEndEditing: { [weak self] text in
                guard let self else { return }
                self.onEndEditing(text)
            },
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
    
    public init(
        view: InputAmountView = .init(),
        viewProperties: InputAmountView.ViewProperties = .init(),
        state: InputAmountViewStyle.State = .default,
        headerStyle: LabelViewStyle = .init(variant: .default(customColor: nil)),
        hintStyle: HintViewStyle = .init(variant: .left, color: .default),
        onBeginEditing: @escaping (String?) -> Void = { _ in },
        onEndEditing: @escaping (String?) -> Void = { _ in },
        onShouldChangeCharacters: @escaping (UITextField, NSRange, String) -> Bool = { _,_,_  in true}
    ) {
        self.view = view
        self.viewProperties = viewProperties
        
        self.headerStyle = headerStyle
        self.hintStyle = hintStyle
        
        self.onBeginEditing = onBeginEditing
        self.onEndEditing = onEndEditing
        self.onShouldChangeCharacters = onShouldChangeCharacters
        
        self.style = InputAmountViewStyle(
            state: state,
            hintStyle: hintStyle,
            headerStyle: headerStyle)
        
        self.viewProperties.textFieldProperties.delegateAssigningClosure = { textField in
            textField.delegate = self.delegate
        }
        
        update()
    }
    
    public func update(
        state: InputAmountViewStyle.State? = nil,
        hintVariant: HintViewStyle.Variant? = nil,
        headerVariant: LabelViewStyle.Variant? = nil
    ) {
        style.update(
            state: state,
            hintVariant: hintVariant,
            headerVariant: headerVariant,
            viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
}

// MARK: - InputAmountViewTextFieldDelegate

private class InputAmountViewTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // MARK: - Private properties
    
    private let onBeginEditing: (String?) -> Void
    private let onEndEditing: (String?) -> Void
    private let onShouldChangeCharacters: (UITextField, NSRange, String) -> Bool
    
    // MARK: - Life cycle
    
    public init(
        onBeginEditing: @escaping (String?) -> Void,
        onEndEditing: @escaping (String?) -> Void,
        onShouldChangeCharacters: @escaping (UITextField, NSRange, String) -> Bool
    ) {
        self.onBeginEditing = onBeginEditing
        self.onEndEditing = onEndEditing
        self.onShouldChangeCharacters = onShouldChangeCharacters
        super.init()
    }
    
    // MARK: - Methods
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        onBeginEditing(textField.text)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        onEndEditing(textField.text)
    }
    
    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        return onShouldChangeCharacters(textField, range, string)
    }
}
