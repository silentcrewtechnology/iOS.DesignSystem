import UIKit
import Components

private func example() {
    let view = InputAmountView()
    let delegate = CustomTextFieldDelegate()
    let style = InputAmountViewStyle()
    var viewProperties = InputAmountView.ViewProperties(
        title: "Title".attributed,
        textFieldProperties: .init(
            text: "123".attributed,
            placeholder: "0".attributed,
            delegateAssigningClosure: { textField in
                textField.delegate = delegate
            }),
        amountSymbol: "₽".attributed,
        isUserInteractionEnabled: true)
    style.update(state: .default,
                 viewProperties: &viewProperties)
    view.update(with: viewProperties)
    
    style.update(state: .error("Error".attributed),
                 viewProperties: &viewProperties)
    view.update(with: viewProperties)
    
    style.update(state: .disabled,
                 viewProperties: &viewProperties)
    view.update(with: viewProperties)
}

private class CustomTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if string.isEmpty { return true }
        guard string.allSatisfy({ "0123456789".contains($0) }) else { return false }
        return true
    }
}
