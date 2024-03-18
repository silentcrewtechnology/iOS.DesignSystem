//
//  BadgeView.swift
//  ABOL
//
//  Created by firdavs on 16.08.2023.
//  Copyright © 2023 ps. All rights reserved.
//

import UIKit

final class BadgeView: UIView {
    
    // MARK: - ViewProperties
    
    struct ViewProperties {
        var text: NSAttributedString?
        var backgroundColor: UIColor?
    }
    
    // MARK: - UI
    
    private var mainView: UIView = {
        let view = UIView()
        view.cornerRadius(
            radius: 10,
            direction: .allCorners,
            clipsToBounds: true
        )
        view.isHidden = true
        return view
    }()
    
    private lazy var titleLabel = UILabel()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addedViews()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - public methods
    
    func update(with viewProperties: ViewProperties?) {
        setText(with: viewProperties)
        setColor(with: viewProperties)
        updateConstraints(with: viewProperties)
    }
    
    func create(with viewProperties: ViewProperties?) {
        setText(with: viewProperties)
        setColor(with: viewProperties)
        updateConstraints(with: viewProperties)
    }
    
    func prepareForReuse() {}
    
    // MARK: - private methods
    
    private func setText(with viewProperties: ViewProperties?) {
        titleLabel.attributedText = viewProperties?.text
        titleLabel.textAlignment = .center
    }
    
    private func setColor(with viewProperties: ViewProperties?) {
        mainView.backgroundColor = viewProperties?.backgroundColor
    }
    
    private func setConstraints() {
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(Constants.labelHeight)
            $0.width.equalTo(Constants.labelHeight)
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(Constants.labelPadding)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func updateConstraints(with viewProperties: ViewProperties?) {
        guard let text = viewProperties?.text else {
            mainView.isHidden = true
            return
        }
        mainView.isHidden = false
        let width = text.width(
            height: CGFloat(Constants.labelHeight),
            add: CGFloat(Constants.labelPadding * 2)
        )
        mainView.snp.updateConstraints {
            $0.width.equalTo(width)
        }
    }
    
    private func addedViews() {
        self.addSubview(mainView)
        mainView.addSubview(titleLabel)
    }
}

private struct Constants {
    
    static let labelPadding = 6
    static let labelHeight = 20
}
