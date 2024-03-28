import UIKit
import Components

private func example() {
    let view = InputAmountView()
    let delegate = CustomTextFieldDelegate()
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
    viewProperties = InputAmountViewStyle.update(state: .default, viewProperties: viewProperties)
    view.update(with: viewProperties)
    viewProperties = InputAmountViewStyle.update(state: .error("Error"), viewProperties: viewProperties)
    view.update(with: viewProperties)
    viewProperties = InputAmountViewStyle.update(state: .disabled, viewProperties: viewProperties)
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
