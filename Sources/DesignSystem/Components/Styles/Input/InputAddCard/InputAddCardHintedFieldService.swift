import UIKit
import Components

public final class InputAddCardHintedFieldService: NSObject {
    
    public typealias V = InputAddCardHintedField
    public typealias Style = InputAddCardHintedFieldStyle
    
    public private(set) var view: V
    public private(set) var viewProperties: V.ViewProperties
    public private(set) var style: Style
    
    public init(
        view: V = .init(),
        viewProperties: V.ViewProperties = .init(),
        style: Style = .init()
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        super.init()
        setupView()
        update()
    }
    
    public func update(
        newState: Style.State? = nil,
        newText: NSMutableAttributedString? = nil,
        newHint: NSMutableAttributedString? = nil
    ) {
        if let newText { viewProperties.textFieldViewProperties.text = newText }
        if let newHint { viewProperties.hint = newHint }
        style.update(state: newState, viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
    
    private func setupView() {
        viewProperties.textFieldViewProperties.delegateAssigningClosure = { [weak self] textField in
            guard let self else { return }
            textField.addTarget(
                self,
                action: #selector(textChanged(textField:)),
                for: .editingChanged
            )
        }
    }
    
    @objc private func textChanged(textField: UITextField) {
        let text = textField.text ?? ""
        viewProperties.textFieldViewProperties.text = text.attributed
    }
}
