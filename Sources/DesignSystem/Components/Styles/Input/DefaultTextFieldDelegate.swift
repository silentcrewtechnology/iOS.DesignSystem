import UIKit

public final class DefaultTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // MARK: - Private properties
    
    private let onBeginEditing: (UITextField) -> Void
    private let onEndEditing: (UITextField) -> Void
    private let onShouldChangeCharacters: (UITextField, NSRange, String) -> Bool
    
    // MARK: - Life cycle
    
    public init(
        onBeginEditing: @escaping (UITextField) -> Void,
        onEndEditing: @escaping (UITextField) -> Void,
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
        onBeginEditing(textField)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        onEndEditing(textField)
    }
    
    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        return onShouldChangeCharacters(textField, range, string)
    }
}
