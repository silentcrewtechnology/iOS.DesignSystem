//
//  NavigationBarService.swift
//
//
//  Created by user on 17.09.2024.
//

import UIKit
import Components

public final class NavigationBarService {
    
    // MARK: - Properties
    
    public private(set) var view: NavigationBar
    public private(set) var viewProperties: NavigationBar.ViewProperties
    public private(set) var style: NavigationBarStyle
    
    // MARK: - Life cycle
    
    public init(
        rootVC: UIViewController,
        viewProperties: NavigationBar.ViewProperties = .init(),
        style: NavigationBarStyle
    ) {
        self.view = .init(rootViewController: rootVC)
        self.viewProperties = viewProperties
        self.style = style
        
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newVariant: NavigationBarStyle.Variant? = nil,
        newColor: NavigationBarStyle.Color? = nil,
        newBackAction: (() -> Void)? = nil
    ) {
        style.update(
            viewProperties: &viewProperties,
            newVariant: newVariant,
            newColor: newColor,
            backAction: newBackAction
        )
        view.update(with: viewProperties)
    }
}
