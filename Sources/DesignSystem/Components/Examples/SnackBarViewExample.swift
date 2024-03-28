//
//  SnackBarViewExample.swift
//
//
//  Created by Ilnur Mugaev on 27.03.2024.
//

import UIKit
import Components

private class SnackBarViewExample: UIViewController {
    
    private lazy var snackBar: SnackBarView = {
        let view = SnackBarView()
        var viewProperties = SnackBarView.ViewProperties(
            title: "Title".attributed,
            content: "Content".attributed,
            closeButton: .init(),
            bottomButton: .init(
                title: "Button".attributed,
                action: { print("Button tapped") }
            )
        )
        
        let style = SnackBarViewStyle(
            color: .light,
            variant: .success,
            delay: .infinite
        )
        style.update(viewProperties: &viewProperties)
        
        view.update(with: viewProperties)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundSecondary
        
        snackBar.show(on: view)
    }
}
