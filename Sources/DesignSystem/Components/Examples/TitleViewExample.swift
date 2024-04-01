//
//  TitleViewExample.swift
//
//
//  Created by Ilnur Mugaev on 01.04.2024.
//

import UIKit
import Components

private class TitleViewExample: UIViewController {
    
    private lazy var iconButtonViewProperties: IconButton.ViewProperties = {
        var viewProperties = IconButton.ViewProperties()
        let style = IconButtonStyle(style: .tertiary, size: .size2XS)
        
        let updateTitleView = { [weak self] in
            guard let self else { return }
            self.titleViewViewProperties.iconButtonViewProperties = viewProperties
            self.titleView.update(with: self.titleViewViewProperties)
        }
        
        viewProperties.image = .ic16Close
        viewProperties.onHighlighted = { isHighlighted in
            style.update(
                state: isHighlighted ? .pressed : .default,
                viewProperties: &viewProperties)
            updateTitleView()
        }
        viewProperties.onTap = {
            updateTitleView()
            print("tapped")
        }
        style.update(state: .default, viewProperties: &viewProperties)
        return viewProperties
    }()
    
    private lazy var titleViewViewProperties: TitleView.ViewProperties = {
        var viewProperties = TitleView.ViewProperties(
            title: "Title text".attributed,
            description: "Description text".attributed,
            iconButtonViewProperties: iconButtonViewProperties
        )
        
        let style = TitleViewStyle(variant: .default, size: .size2XL)
        style.update(viewProperties: &viewProperties)
        return viewProperties
    }()
    
    private lazy var titleView: TitleView = {
        let view = TitleView()
        view.update(with: titleViewViewProperties)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundSecondary
        
        view.addSubview(titleView)
        titleView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.topMargin.equalToSuperview().inset(20)
        }
    }
}
