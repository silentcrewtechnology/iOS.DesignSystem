import UIKit

public final class DefaultTextViewDelegate: NSObject, UITextViewDelegate {
    
    // MARK: - Private properties
    
    private let onBeginEditing: (String?) -> Void
    private let onEndEditing: (String?) -> Void
    private let onShouldChangeText: (UITextView, NSRange, String) -> Bool
    private let onTextChanged: (String?) -> Void
    
    // MARK: - Life cycle
    
    public init(
        onBeginEditing: @escaping (String?) -> Void,
        onEndEditing: @escaping (String?) -> Void,
        onShouldChangeText: @escaping (UITextView, NSRange, String) -> Bool,
        onTextChanged: @escaping (String?) -> Void
    ) {
        self.onBeginEditing = onBeginEditing
        self.onEndEditing = onEndEditing
        self.onShouldChangeText = onShouldChangeText
        self.onTextChanged = onTextChanged

        super.init()
    }
    
    // MARK: - Methods
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        onBeginEditing(textView.text)
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        onEndEditing(textView.text)
    }
    
    public func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String
    ) -> Bool {
        onShouldChangeText(textView, range, text)
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        onTextChanged(textView.text)
    }
}
