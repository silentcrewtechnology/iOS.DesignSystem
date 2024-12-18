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
        
        setupStateChanging()
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
        if let newPlaceholder {
            viewProperties.textField.placeholder = newPlaceholder
        }
        
        if let newTextDidChange {
            viewProperties.textDidChange = newTextDidChange
        }
        
        if let newCancelButtonClicked {
            viewProperties.cancelButtonClicked = newCancelButtonClicked
        }
        
        if let newTextDidBeginEditing {
            viewProperties.textDidBeginEditing = newTextDidBeginEditing
        }
        
        if let newTextDidEndEditing {
            viewProperties.textDidEndEditing = newTextDidEndEditing
        }
       
        style.update(
            newState: newState,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
        setupStateChanging()
    }
    
    // MARK: - Private methods
    
    private func setupStateChanging() {
        let didBeginEditing = viewProperties.textDidBeginEditing
        let didEndEditing = viewProperties.textDidEndEditing
    
        viewProperties.textDidBeginEditing = { [weak self] in
            self?.update(newState: .active)
            didBeginEditing?()
        }
        
        viewProperties.textDidEndEditing = { [weak self] in
            self?.update(newState: .default)
            didEndEditing?()
        }
    }
}
