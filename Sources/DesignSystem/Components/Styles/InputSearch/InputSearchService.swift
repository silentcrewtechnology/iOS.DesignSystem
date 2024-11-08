//
//  InputSearchService.swift
//
//
//  Created by user on 22.10.2024.
//

import UIKit
import Components

public final class InputSearchService {
    
    // MARK: - Properties
    
    public private(set) var view: InputSearchView
    public private(set) var viewProperties: InputSearchView.ViewProperties
    public private(set) var style: InputSearchStyle
    
    // MARK: - Init
    
    public init(
        view: InputSearchView = .init(),
        viewProperties: InputSearchView.ViewProperties = .init(),
        style: InputSearchStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newState: InputSearchStyle.State? = nil,
        newPlaceholder: NSMutableAttributedString? = nil,
        newTextDidChange: ((String) -> Void)? = nil,
        newCancelButtonClicked: (() -> Void)? = nil,
        newTextDidBeginEditing: (() -> Void)? = nil,
        newTextDidEndEditing: (() -> Void)? = nil
    ) {
        viewProperties.textField.placeholder = newPlaceholder ?? viewProperties.textField.placeholder
        style.update(
            newState: newState,
            viewProperties: &viewProperties,
            textDidChange: newTextDidChange ?? viewProperties.textDidChange,
            cancelButtonClicked: newCancelButtonClicked ?? viewProperties.cancelButtonClicked,
            textDidBeginEditing: newTextDidBeginEditing ?? viewProperties.textDidBeginEditing,
            textDidEndEditing: newTextDidEndEditing ?? viewProperties.textDidEndEditing
        )
        view.update(with: viewProperties)
    }
}
