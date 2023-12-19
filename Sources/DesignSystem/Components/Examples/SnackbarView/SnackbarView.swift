//
//  SnackbarView.swift
//  
//
//  Created by Firdavs on 29.03.2023.
//
import SnapKit
import Architecture
import UIKit

public final class SnackbarView: UIView, ViewProtocol {
    
    public struct ViewProperties {
        public let title: NSAttributedString?
        public var content: NSAttributedString?
        public let subtitle: NSAttributedString?
        public let iconImage: UIImage?
        public let backgroundColor: UIColor?
        public let closeAction: ClosureEmpty
        
        public init(
            title: NSAttributedString?,
            content: NSAttributedString?,
            subtitle: NSAttributedString?,
            iconImage: UIImage?,
            backgroundColor: UIColor?,
            closeAction: @escaping ClosureEmpty
        ) {
            self.title = title
            self.content = content
            self.subtitle = subtitle
            self.iconImage = iconImage
            self.backgroundColor = backgroundColor
            self.closeAction = closeAction
        }
    }
    
    //MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private let titlesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    //MARK: - private preperties
    private var viewProperties: ViewProperties?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - public methods
    
    public func create(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
        addedViews()
        setupConstraints()
        setupActionButton()
        setData(with: viewProperties)
        setupView()
    }
    
    public func update(viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
        setData(with: viewProperties)
    }
    
    //MARK: - private methods
    
    private func setData(with viewProperties: ViewProperties?){
        titleLabel.attributedText = viewProperties?.title
        contentLabel.attributedText = viewProperties?.content
        subtitleLabel.attributedText = viewProperties?.subtitle
        iconImageView.image = viewProperties?.iconImage
        backgroundColor = viewProperties?.backgroundColor
    }
    
    private func setupView(){
        self.cornerRadius(
            radius: 12,
            direction: .allCorners,
            clipsToBounds: true
        )
    }
    
    private func setupActionButton(){
        let action = #selector(didTapAction)
        closeButton.addTarget(self, action: action, for: .touchUpInside)
    }
    
    private func addedViews(){
        addSubview(iconImageView)
        addSubview(closeButton)
        addSubview(titlesStackView)
        titlesStackView.addArrangedSubview(titleLabel)
        titlesStackView.addArrangedSubview(contentLabel)
        titlesStackView.addArrangedSubview(subtitleLabel)
    }
    
    private func setupConstraints(){
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(18)
            $0.width.height.equalTo(20)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.trailing.equalToSuperview().inset(18)
            $0.width.height.equalTo(20)
        }
        
        titlesStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.equalTo(iconImageView.snp.trailing).inset(-14)
        }
    }
    
    @objc
    private func didTapAction(){
        self.viewProperties?.closeAction()
    }
}
