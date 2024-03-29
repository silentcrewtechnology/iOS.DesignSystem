import UIKit
import SnapKit
import Components
import Colors
import ImagesService

public final class ButtonView: UIButton {
    
    public struct ViewProperties {
        public var attributedText: NSMutableAttributedString
        public var leftIcon: UIImage?
        public var rightIcon: UIImage?
        public var backgroundColor: UIColor
        public var highlightColor: UIColor
        public var activityIndicator: ActivityIndicatorView.ViewProperties
        public var action: () -> Void
        
        public init(
            attributedText: NSMutableAttributedString = "".attributed,
            leftIcon: UIImage? = nil,
            rightIcon: UIImage? = nil,
            backgroundColor: UIColor = .backgroundAction,
            highlightColor: UIColor = .backgroundActionPressed,
            activityIndicator: ActivityIndicatorView.ViewProperties = .init(),
            action: @escaping () -> Void = { }
        ) {
            self.attributedText = attributedText
            self.leftIcon = leftIcon
            self.rightIcon = rightIcon
            self.backgroundColor = backgroundColor
            self.highlightColor = highlightColor
            self.activityIndicator = activityIndicator
            self.action = action
        }
    }
    
    private var viewProperties: ViewProperties = .init()
    
    // MARK: - UI
    
    private let activityIndicator = ActivityIndicatorView()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.isUserInteractionEnabled = false
        return stackView
    }()
    
    private let leftIconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        return view
    }()
    
    private let rightIconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        return view
    }()
    
    public override var isHighlighted: Bool {
        didSet {
            UIView.animate(
                withDuration: 0.25,
                delay: 0,
                options: [.beginFromCurrentState, .allowUserInteraction],
                animations: { [self] in
                    self.backgroundColor = self.isHighlighted
                    ? viewProperties.highlightColor
                    : viewProperties.backgroundColor
                },
                completion: nil)
        }
    }
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Public Methods
    
    public func update(with viewProperties: ViewProperties) {
        setupProperties(with: viewProperties)
        setupActionButton(with: viewProperties)
        updateIndicator(indicator: viewProperties.activityIndicator)
        self.viewProperties = viewProperties
    }
    
    // MARK: - Private Methods
    
    private func setupProperties(with viewProperties: ViewProperties) {
        backgroundColor = viewProperties.backgroundColor
        
        if let leftIcon = viewProperties.leftIcon {
            leftIconView.image = leftIcon
        } else {
            stackView.removeArrangedSubview(leftIconView)
        }
        
        if let rightIcon = viewProperties.rightIcon {
            rightIconView.image = rightIcon
        } else {
            stackView.removeArrangedSubview(rightIconView)
        }
    }
    
    private func setupActionButton(with viewProperties: ViewProperties) {
        addTarget(self, action: #selector(didTapAction), for: .touchUpInside)
        setAttributedTitle(viewProperties.attributedText, for: .normal)
    }
    
    private func setupView() {
        guard let titleLabel else { return }
        
        layer.cornerRadius = 8
        
        [stackView, activityIndicator].forEach { addSubview($0) }
        [leftIconView, titleLabel, rightIconView].forEach { stackView.addArrangedSubview($0) }
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview().offset(16)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 24, height: 24))
        }
    }
    
    private func updateIndicator(indicator: ActivityIndicatorView.ViewProperties) {
        let isLoading = indicator.isAnimating
        isUserInteractionEnabled = !isLoading
        
        if isLoading {
            backgroundColor = backgroundColor != .clear
            ? .backgroundDisabled
            : viewProperties.backgroundColor
        } else {
            backgroundColor = viewProperties.backgroundColor
        }
        
        stackView.isHidden = isLoading
        activityIndicator.update(with: indicator)
    }
    
    @objc
    private func didTapAction() {
        self.viewProperties.action()
    }
}
