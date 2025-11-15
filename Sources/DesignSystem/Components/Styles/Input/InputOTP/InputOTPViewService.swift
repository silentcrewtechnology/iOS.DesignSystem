import UIKit
import Components

public final class InputOTPViewService {
    
    // MARK: - Properties
    
    public private(set) var view: InputOTPView
    public private(set) var viewProperties: InputOTPView.ViewProperties
    public private(set) var style:InputOTPViewStyle
    public private(set) var hintService = HintViewService(
        style: .init(variant: .center, color: .error)
    )
    public private(set) var itemServices: [InputOTPItemViewService]
    
    // MARK: - Private properties
    
    private var onBeginEditing: (UITextField) -> Void
    private var onEndEditing: (UITextField) -> Void
    private var onShouldChangeCharacters: (UITextField, NSRange, String) -> Bool
    private var currentIndex: Int = .zero
    
    private lazy var delegate: DefaultTextFieldDelegate = {
        let delegate = DefaultTextFieldDelegate(
            onBeginEditing: { [weak self] textField in
                guard let self else { return }
                if self.itemServices[self.currentIndex].style.state != .active {
                    self.update(newState: .active, range: currentIndex..<currentIndex + 1)
                }
                self.onBeginEditing(textField)
            },
            onEndEditing: { [weak self] textField in
                guard let self else { return }
                self.update(
                    newState: self.style.state == .disabled ? .disabled : .default,
                    range: 0..<self.itemServices.count
                )
                self.onEndEditing(textField)
            },
            onShouldChangeCharacters: { [weak self] textField, range, string in
                guard let self, let text = textField.text else { return false }
                
                if text.count >= itemServices.count, string != "" {
                    textField.text?.removeLast()
                }

                return true
            }
        )
        
        return delegate
    }()
    
    // MARK: - Init
    
    public init(
        view: InputOTPView = .init(),
        viewProperties: InputOTPView.ViewProperties = .init(),
        style: InputOTPViewStyle,
        itemServices: [InputOTPItemViewService] = [],
        onBeginEditing: @escaping (UITextField) -> Void = { _ in },
        onEndEditing: @escaping (UITextField) -> Void = { _ in },
        onShouldChangeCharacters: @escaping (UITextField, NSRange, String) -> Bool = { _,_,_  in true}
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        self.itemServices = itemServices
        self.onBeginEditing = onBeginEditing
        self.onEndEditing = onEndEditing
        self.onShouldChangeCharacters = onShouldChangeCharacters
        
        self.viewProperties.hintView = hintService.view
        self.viewProperties.itemViews = itemServices.map { $0.view }
        self.viewProperties.textFieldViewProperties.delegateAssigningClosure = { [weak self] textField in
            guard let self else { return }
            textField.delegate = self.delegate
            textField.addTarget(
                self,
                action: #selector(self.textChanged(textField:)),
                for: .editingChanged
            )
        }
        
        changeHintIsHidden(with: style.state)
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newState: InputOTPItemViewStyle.State? = nil,
        range: Range<Int>,
        onTextChanged: ((String?) -> Void)? = nil
    ) {
        if let newState {
            changeHintIsHidden(with: newState)
            changeState(newState, range: range)
        }
 
        if let onTextChanged {
            viewProperties.onTextChanged = onTextChanged
        }
        
        style.update(
            state: newState,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
    
    // MARK: - Private methods
    
    private func changeHintIsHidden(with state: InputOTPItemViewStyle.State) {
        switch state {
        case .error:
            hintService.update(newVariant: .center, newColor: .error)
        default:
            hintService.update(newVariant: .empty)
        }
    }
    
    private func update() {
        style.update(viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
    
    private func changeState(
        _ state: InputOTPItemViewStyle.State,
        range: Range<Int>
    ) {
        for (i, itemService) in itemServices.enumerated() {
            if range ~= i {
                itemService.update(newState: state)
            } else {
                itemService.update(newState: .default)
            }
        }
    }
    
    @objc private func textChanged(textField: UITextField) {
        let stringCode = (textField.text ?? "").map { "\($0)" }
        let isLastNumber = stringCode.count == itemServices.count
        currentIndex = stringCode.count
        if isLastNumber { currentIndex -= 1 }
        for index in itemServices.indices {
            var newState: InputOTPItemViewStyle.State = .default
            var newText: NSMutableAttributedString = .init(string: "")
            if index < currentIndex {
                newText = .init(string: "\(stringCode[index])")
            } else if index == currentIndex {
                newState = .active
                if isLastNumber { newText = .init(string: "\(stringCode[index])") }
            }
            
            itemServices[index].update(
                newState: newState,
                newText: newText
            )
        }
        
        viewProperties.textFieldViewProperties.text = textField.text?.attributed ?? .init(string: "")
        viewProperties.onTextChanged?(textField.text)
    }
}
