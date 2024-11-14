//
//  ButtonViewService.swift
//
//
//  Created by user on 14.10.2024.
//

import UIKit
import Components

public final class ButtonViewService {
    
    // MARK: - Properties
    
    public private(set) var view: ButtonView
    public private(set) var viewProperties: ButtonView.ViewProperties
    public private(set) var style: ButtonViewStyle
    public private(set) lazy var loaderService: LoaderViewService = .init(
        style: .init(color: .main, size: .s),
        isHidden: true
    )
    
    // MARK: - Init
    
    public init(
        view: ButtonView = .init(),
        viewProperties: ButtonView.ViewProperties = .init(),
        style: ButtonViewStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        
        self.viewProperties.loader = self.loaderService.view
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newSize: ButtonViewStyle.Size? = nil,
        newColor: ButtonViewStyle.Color? = nil,
        newVariant: ButtonViewStyle.Variant? = nil,
        newState: ButtonViewStyle.State? = nil,
        newIcon: ButtonViewStyle.Icon? = nil,
        newText: NSMutableAttributedString? = nil
    ) {
        if let newText {
            viewProperties.attributedText = newText
        }

        style.update(
            size: newSize,
            color: newColor,
            variant: newVariant,
            state: newState,
            icon: newIcon,
            viewProperties: &viewProperties
        )
        let isHidden: Bool = {
            guard let newState else { return loaderService.viewProperties.isHidden }
            return newState != .loading
        }()
        loaderService.update(newStyle: style.loaderStyle(), isHidden: isHidden)
        view.update(with: viewProperties)
    }
}
