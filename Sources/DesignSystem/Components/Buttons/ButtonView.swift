import UIKit
import SnapKit
import Architecture

public final class ButtonView: UIButton, ViewProtocol {
    
    public struct ViewProperties {
        public var attributedText: NSMutableAttributedString
        public var leftIcon: UIImage?
        public var rightIcon: UIImage?
        public var backgroundColor: UIColor
        public var higlightColor: UIColor
        public var action: ClosureEmpty
        
        public init(
            attributedText: NSMutableAttributedString,
            leftIcon: UIImage? = nil,
            rightIcon: UIImage? = nil,
            backgroundColor: UIColor = .backgroundAction,
            higlightColor: UIColor = .backgroundActionPressed,
            action: @escaping ClosureEmpty = { }
        ) {
            self.attributedText = attributedText
            self.leftIcon = leftIcon
            self.rightIcon = rightIcon
            self.backgroundColor = backgroundColor
            self.higlightColor = higlightColor
            self.action = action
        }
    }
    
    private var viewProperties: ViewProperties?
    
    // MARK: - UI
    
    private lazy var activityIndicator: ActivityIndicatorView = {
        let view = ActivityIndicatorView(image: .ic24SpinerLoader.tinted(with: .contentDisabled))
        view.isHidden = true
        return view
    }()
        
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
                    ? viewProperties?.higlightColor
                    : viewProperties?.backgroundColor
                },
                completion: nil)
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Public Methods
    
    public func create(with viewProperties: ViewProperties?) {
        guard let viewProperties else { return }
        self.viewProperties = viewProperties
        setupProperties(with: viewProperties)
    }
    
    public func update(viewProperties: ViewProperties?) {
        guard let viewProperties else { return }
        self.viewProperties = viewProperties
        setupProperties(with: viewProperties)
    }
    
    public func startLoading() {
        setupActivityIndicator(isLoading: true)
    }
    
    public func stopLoading() {
        setupActivityIndicator(isLoading: false)
    }
    
    // MARK: - Private Methods
    
    private func setupProperties(with viewProperties: ViewProperties?) {
        guard let viewProperties else { return }

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
        
        setupActionButton(with: viewProperties)
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
    
    private func setupActivityIndicator(isLoading: Bool) {
        isUserInteractionEnabled = !isLoading
        
        if isLoading {
            backgroundColor = backgroundColor != .clear
            ? .backgroundDisabled
            : viewProperties?.backgroundColor
        } else {
            backgroundColor = viewProperties?.backgroundColor
        }
        
        stackView.isHidden = isLoading
        activityIndicator.isHidden = !isLoading
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    @objc
    private func didTapAction() {
        self.viewProperties?.action()
    }
}
