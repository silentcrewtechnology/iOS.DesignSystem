import UIKit
import SnapKit
import Architecture

public final class ButtonView: UIView, ViewProtocol {
    
    public struct ViewProperties {
        public var attributedText: NSMutableAttributedString
        public var leftIcon: UIImage?
        public var rightIcon: UIImage?
        public var loaderImage: UIImage?
        public var backgroundColor: UIColor
        public var action: ClosureEmpty
        
        public init(
            attributedText: NSMutableAttributedString,
            leftIcon: UIImage? = nil,
            rightIcon: UIImage? = nil,
            loaderImage: UIImage? = nil,
            backgroundColor: UIColor = .backgroundAction,
            action: @escaping ClosureEmpty = { }
        ) {
            self.attributedText = attributedText
            self.leftIcon = leftIcon
            self.rightIcon = rightIcon
            self.loaderImage = loaderImage
            self.backgroundColor = backgroundColor
            self.action = action
        }
    }
    
    private var viewProperties: ViewProperties?
    
    // MARK: - UI
    
    private var activityIndicator: ActivityIndicatorView = {
        let view = ActivityIndicatorView()
        view.isHidden = true
        return view
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.contentActionOn, for: .normal)
        button.titleLabel?.font = .textM
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 16
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
        setupView()
        setupProperties(with: viewProperties)
    }
    
    public func update(with viewProperties: ViewProperties?) {
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

        leftIconView.image = viewProperties.leftIcon
        rightIconView.image = viewProperties.rightIcon
        
        if let loaderImage = viewProperties.loaderImage {
            activityIndicator = .init(image: loaderImage)
        }
        
        setupActionButton(with: viewProperties)
    }
    
    private func setupActionButton(with viewProperties: ViewProperties) {
        actionButton.addTarget(self, action: #selector(didTapAction), for: .touchUpInside)
        actionButton.setAttributedTitle(viewProperties.attributedText, for: .normal)
    }
    
    private func setupView() {
        layer.cornerRadius = 8
        
        [activityIndicator, stackView].forEach { addSubview($0) }
        [leftIconView, actionButton, rightIconView].forEach { stackView.addArrangedSubview($0) }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview().offset(16)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }
    }
    
    private func setupActivityIndicator(isLoading: Bool) {
        isUserInteractionEnabled = !isLoading
        activityIndicator.isHidden = !isLoading
        leftIconView.isHidden = isLoading
        rightIconView.isHidden = isLoading
        actionButton.isHidden = isLoading
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    @objc
    private func didTapAction(){
        self.viewProperties?.action()
    }
}
