import UIKit

public final class InputAmountViewTextFieldDelegate: NSObject, UITextFieldDelegate {
    
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
