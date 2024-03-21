import UIKit
import SnapKit
import Colors

public final class MessageView: UIView {
    
    public struct ViewProperties {
        public var attributedText: NSMutableAttributedString?
        public var attributedPlaceholder: NSMutableAttributedString?
        public var backgroundColor: UIColor
        public var borderColor: UIColor
        public var isUserInteractionEnabled: Bool

        public init(
            attributedText: NSMutableAttributedString? = nil,
            attributedPlaceholder: NSMutableAttributedString? = nil,
            backgroundColor: UIColor = .backgroundPrimary,
            borderColor: UIColor = .clear,
            isUserInteractionEnabled: Bool = true
        ) {
            self.attributedText = attributedText
            self.attributedPlaceholder = attributedPlaceholder
            self.backgroundColor = backgroundColor
            self.borderColor = borderColor
            self.isUserInteractionEnabled = isUserInteractionEnabled
        }
    }
        
    // MARK: - UI
    
    private lazy var textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.borderStyle = .none
        textField.delegate = self
        return textField
    }()
    
    // MARK: - Private Properties

    private var viewProperties: ViewProperties = .init()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayer()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Public Methods
    
    public func update(with viewProperties: ViewProperties) {
        setupProperties(with: viewProperties)
        self.viewProperties = viewProperties
    }
    
    // MARK: - Private Methods
    
    private func setupProperties(with viewProperties: ViewProperties) {
        backgroundColor = viewProperties.backgroundColor
        layer.borderColor = viewProperties.borderColor.cgColor

        textField.attributedText = viewProperties.attributedText
        textField.attributedPlaceholder = viewProperties.attributedPlaceholder
        
        isUserInteractionEnabled = viewProperties.isUserInteractionEnabled
    }
    
    private func setupView() {
        addSubview(textField)
        textField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupLayer() {
        layer.borderWidth = 1
        layer.cornerRadius = 28
    }
}

// MARK: - UITextFieldDelegate

extension MessageView: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        let updatedProperties = MessageViewStyle.updateStyle(
            style: .active,
            viewProperties: viewProperties
        )
        
        update(with: updatedProperties)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        let updatedProperties = MessageViewStyle.updateStyle(
            style: .default,
            viewProperties: .init(attributedText: textField.text?.attributed)
        )
        
        update(with: updatedProperties)
    }
}
