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
        view: NavigationBar? = nil,
        viewProperties: NavigationBar.ViewProperties = .init(),
        style: NavigationBarStyle
    ) {
        if let view {
            self.view = view
        } else {
            self.view = .init(rootViewController: rootVC)
        }
        
        self.viewProperties = viewProperties
        self.style = style
        
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newVariant: NavigationBarStyle.Variant? = nil,
        newColor: NavigationBarStyle.Color? = nil,
        newRightBarButtonItems: [UIBarButtonItem]? = nil,
        newBackAction: (() -> Void)? = nil
    ) {
        if let newRightBarButtonItems {
            viewProperties.rightBarButtonItems = newRightBarButtonItems
        }
    
        style.update(
            viewProperties: &viewProperties,
            newVariant: newVariant,
            newColor: newColor,
            backAction: newBackAction
        )
        view.update(with: viewProperties)
    }
}
