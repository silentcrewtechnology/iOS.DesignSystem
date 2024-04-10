import UIKit
import Components

private func example() {
    let view = InputOTPView()
    let viewProperties = InputOTPView.ViewProperties(
        items: otpItems(),
        hint: hintProperties())
    view.update(with: viewProperties)
}

private func otpItems() -> [InputOTPItemView.ViewProperties] {
    let states: [InputOTPItemViewStyle.State] = [.default, .active, .error, .disabled]
    return states.map { state in
        let style = InputOTPItemViewStyle()
        var viewProperties = InputOTPItemView.ViewProperties()
        style.update(state: state, viewProperties: &viewProperties)
        return viewProperties
    }
}

private func hintProperties() -> HintView.ViewProperties {
    var viewProperties = HintView.ViewProperties()
    HintViewStyle().update(
        variant: .right("Hint".attributed),
        viewProperties: &viewProperties)
    return viewProperties
}

private class InputOTPFeature: NSObject, UITextFieldDelegate {
    
    private var maxCount: Int = 5
    
    let view = InputOTPView()
    private let itemStyle = InputOTPItemViewStyle()
    private let hintStyle = HintViewStyle()
    private lazy var viewProperties = InputOTPView.ViewProperties(
        items: (0..<maxCount).map { _ in .init() },
        hint: .init())
    
    private(set) lazy var textField: UITextField = {
        let field = UITextField()
        field.keyboardType = .numberPad
        field.textContentType = .oneTimeCode
        field.addTarget(self, action: #selector(onTextChange(textField:)), for: .editingChanged)
        field.delegate = self
        field.isHidden = true
        return field
    }()
    
    public override init() {
        super.init()
        setupView()
    }
    
    private func setupView() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(fieldTapped)))
        view.addSubview(textField)
        reset()
    }
    
    private func reset() {
        for i in viewProperties.items.indices {
            viewProperties.items[i].text = "".attributed
            itemStyle.update(state: .default, viewProperties: &viewProperties.items[i])
        }
        hintStyle.update(variant: .empty, viewProperties: &viewProperties.hint)
        view.update(with: viewProperties)
    }
    
    @objc private func onTextChange(textField: UITextField) {
        let text = (textField.text ?? "").map { "\($0)" }
        for i in viewProperties.items.indices {
            if i < text.count {
                viewProperties.items[i].text = "\(text[i])".attributed
                itemStyle.update(state: .active, viewProperties: &viewProperties.items[i])
            } else {
                viewProperties.items[i].text = "".attributed
                itemStyle.update(state: .default, viewProperties: &viewProperties.items[i])
            }
        }
        view.update(with: viewProperties)
    }
    
    @objc private func fieldTapped() {
        textField.becomeFirstResponder()
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard
            string.isEmpty
                || CharacterSet(charactersIn: string).isSubset(of: .decimalDigits),
            let text = textField.text,
            text.count + string.count <= maxCount
        else { return false }
        return true
    }
    
    func showLeftError(message: String) {
        textField.resignFirstResponder()
        hintStyle.update(
            variant: .left(message.attributed.foregroundColor(.contentError)),
            viewProperties: &viewProperties.hint)
        for i in viewProperties.items.indices {
            itemStyle.update(state: .error, viewProperties: &viewProperties.items[i])
        }
        view.update(with: viewProperties)
    }
}
