import UIKit
import Components

public protocol InputViewServiceProtocol {
    var view: InputView { get }
    var viewProperties: InputView.ViewProperties { get }
    var style: InputViewStyle { get }
    var onTextChange: ((String) -> Void)? { get set }
    
    init(
        view: InputView,
        viewProperties: InputView.ViewProperties,
        style: InputViewStyle,
        onTextChange: ((String) -> Void)?
    )
    
    func update(
        with parameters: InputViewService.InputUpdateParameters?
    )
}

public final class InputViewService: InputViewServiceProtocol {
    public private(set) var view: InputView
    public private(set) var viewProperties: InputView.ViewProperties
    public private(set) var style: InputViewStyle
    
    public var onTextChange: ((String) -> Void)?
    
    // MARK: - Init
    public init(
        view: InputView = .init(),
        viewProperties: InputView.ViewProperties = .init(),
        style: InputViewStyle,
        onTextChange: ((String) -> Void)? = nil
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        self.onTextChange = onTextChange
        
        self.viewProperties.textFieldViewProperties.delegateAssigningClosure = { [weak self] textField in
            guard let self else { return }
            textField.addTarget(
                self,
                action: #selector(textFieldDidChange(_:)),
                for: .editingChanged
            )
        }
    }
    
    // MARK: - UpdateParameters
    
    public struct InputUpdateParameters {
        var state: InputViewStyle.State? = nil
        var set: InputViewStyle.Set? = nil
        
        public init(
            state: InputViewStyle.State? = nil,
            set: InputViewStyle.Set? = nil
        ) {
            self.state = state
            self.set = set
        }
    }
    
    // MARK: - Methods
    
    public func update(
        with parameters: InputUpdateParameters? = nil
    ) {
        style.update(
            state: parameters?.state,
            set: parameters?.set,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        onTextChange?(text)
    }
}

extension InputViewService {
    @available(*, deprecated, message: "Use  update(with parameters:")
    public func update(
        state: InputViewStyle.State? = nil,
        set: InputViewStyle.Set? = nil
    ) {
        update(with: .init(
            state: state,
            set: set
        ))
    }
}
