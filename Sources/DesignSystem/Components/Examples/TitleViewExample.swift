//
//  TitleViewExample.swift
//
//
//  Created by Ilnur Mugaev on 01.04.2024.
//

import UIKit
import Components

private class TitleViewExample: UIViewController {
    private lazy var titleViewViewProperties: TitleView.ViewProperties = {
        var viewProperties = TitleView.ViewProperties(title: .init(string: "Title"))
        let style = TitleViewStyle(size: .extraLarge, color: .primary)
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
