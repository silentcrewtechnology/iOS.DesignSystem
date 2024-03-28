import UIKit
import Components

private class Example {
    
    let view = InputMessageView()
    var viewProperties = InputMessageView.ViewProperties()
    
    func example() {
        let style = InputMessageViewStyle(style: .default)
        viewProperties.text = "Content".attributed
        viewProperties.placeholder = "PlaceHolder".attributed
        let delegate = MessageViewTextFieldDelegate(
            onBeginEditing: { [weak self] in
                guard let self else { return }
                let style = InputMessageViewStyle(style: .active)
                style.update(viewProperties: &self.viewProperties)
                self.view.update(with: viewProperties)
            },
            onEndEditing: { [weak self] text in
                guard let self else { return }
                let style = InputMessageViewStyle(style: .default)
                self.viewProperties.text = text?.attributed
                style.update(viewProperties: &self.viewProperties)
                self.view.update(with: viewProperties)
            })
        viewProperties.delegateAssigningClosure = { textField in
            textField.delegate = delegate
        }
        style.update(viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
}

private class MessageViewTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    private let onBeginEditing: () -> Void
    private let onEndEditing: (String?) -> Void
    
    public init(
        onBeginEditing: @escaping () -> Void,
        onEndEditing: @escaping (String?) -> Void
    ) {
        self.onBeginEditing = onBeginEditing
        self.onEndEditing = onEndEditing
        super.init()
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        onBeginEditing()
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        onEndEditing(textField.text)
    }
}
