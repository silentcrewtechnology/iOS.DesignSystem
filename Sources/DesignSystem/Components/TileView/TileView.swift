import UIKit
import SnapKit
import Architecture

final class TileView: UIView, ViewProtocol {
    
    struct ViewProperties {
        var icon: Icon = .init()
        var text: NSMutableAttributedString = .init(string: "")
        var backgroundColor: UIColor = .clear
        var width: CGFloat = .zero
        var textWidth: CGFloat = .zero
        var action: () -> Void = { }
        
        struct Icon {
            var variant: Variant = .icon(.init())
            var backgroundColor: UIColor = .clear
            
            enum Variant {
                case icon(UIImage)
                case image(UIImage)
            }
        }
    }
    
    private var viewProperties: ViewProperties = .init()
    
    private let iconView: UIImageView = {
        let view = UIImageView()
            .circled(diameter: 48)
        view.contentMode = .center
        return view
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }
    
    func create(with viewProperties: ViewProperties?) {
        guard let viewProperties else { return }
        self.viewProperties = viewProperties
        textLabel.attributedText = viewProperties.text.alignment(.center)
        setupIcon(with: viewProperties)
    }
    
    func update(with viewProperties: ViewProperties?) {
        guard let viewProperties else { return }
        textLabel.attributedText = viewProperties.text
        setupSizeConstraints()
        backgroundColor = viewProperties.backgroundColor
        setupIcon(with: viewProperties)
        self.viewProperties = viewProperties
    }
    
    private func setupView() {
        layer.cornerRadius = 12
        snp.makeConstraints {
            $0.width.equalTo(0) // будет обновлён
        }
        addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }
        addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.top.equalTo(iconView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview().inset(16)
            $0.width.equalTo(0) // будет обновлён
        }
        setupGestureRecognizer()
    }
    
    private func setupGestureRecognizer() {
        let gr = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(gr)
    }
    
    private func setupSizeConstraints() {
        guard
            self.viewProperties.width != viewProperties.width,
            self.viewProperties.textWidth != viewProperties.textWidth
        else { return }
        snp.updateConstraints {
            $0.width.equalTo(viewProperties.width)
        }
        textLabel.snp.updateConstraints {
            $0.width.equalTo(viewProperties.textWidth)
        }
    }
    
    private func setupIcon(with viewProperties: ViewProperties) {
        switch viewProperties.icon.variant {
        case .icon(let image):
            iconView.contentMode = .center
            iconView.image = image
        case .image(let image):
            iconView.contentMode = .scaleAspectFill
            iconView.image = image
        }
        iconView.backgroundColor = viewProperties.icon.backgroundColor
    }
    
    @objc
    private func tapped() {
        viewProperties.action()
    }
}
