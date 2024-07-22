//
//  NavigationBarExample.swift
//
//
//  Created by user on 22.07.2024.
//

import UIKit
import Components
import ImagesService

private class NavigationBarExample: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let vc = UINavigationController()
        var navVP = NavigationBar.ViewProperties()
        let navVCStyle = NavigationBarStyle(
            variant: .mainScreen(
                name: "Алиса",
                margins: nil,
                onProfile: profileTapped
            ),
            color: .primary
        )
        navVCStyle.update(viewProperties: &navVP)
        navVP.rightBarButtonItems = [.init(
            image: .ic24QrCode
                .withTintColor(.contentPrimary)
                .withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(qrCodeTapped)
        )]
        let navVC = NavigationBar(rootViewController: vc)
        navVC.update(with: navVP)
        vc.hidesBottomBarWhenPushed = false
        
        navVC.pushViewController(vc, animated: true)
    }
    
    private func profileTapped() {
        // Profile action
    }
    
    @objc private func qrCodeTapped() {
        // QR-code action
    }
}
