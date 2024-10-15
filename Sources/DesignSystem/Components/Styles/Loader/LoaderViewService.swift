//
//  LoaderViewService.swift
//
//
//  Created by user on 04.10.2024.
//

import UIKit
import Components

public final class LoaderViewService {
    
    // MARK: - Properties
    
    public private(set) var view: LoaderView
    public private(set) var viewProperties: LoaderView.ViewProperties
    public private(set) var style: LoaderViewStyle
    
    // MARK: - Init
    
    public init(
        view: LoaderView = .init(),
        viewProperties: LoaderView.ViewProperties = .init(),
        style: LoaderViewStyle,
        isHidden: Bool = true
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        self.viewProperties.isHidden = isHidden
    }
    
    // MARK: - Methods
    
    public func update(
        newColor: LoaderViewStyle.Color? = nil,
        newSize: LoaderViewStyle.Size? = nil,
        newStyle: LoaderViewStyle? = nil,
        isHidden: Bool = true
    ) {
        if let newStyle {
            style = newStyle
        }
        
        style.update(
            newColor: newColor,
            newSize: newSize,
            viewProperties: &viewProperties
        )
        viewProperties.isHidden = isHidden
        view.update(with: viewProperties)
    }
}
