//
//  InputSearchStyle.swift
//
//
//  Created by user on 22.10.2024.
//

import UIKit
import Components
import Extensions
import Colors

public final class InputSearchStyle {
    
    // MARK: - Properties
    
    public enum State {
        case `default`
        case active
    }
    
    // MARK: - Private properties
    
    private var state: State
    
    // MARK: - Life cycle
    
    public init(state: State) {
        self.state = state
    }
    
    // MARK: - Methods
    
    public func update(
        newState: State? = nil,
        viewProperties: inout InputSearchView.ViewProperties
    ) {
        if let newState {
            state = newState
        }
        
        viewProperties.cancelButtonText = "Отменить"
        viewProperties.cancelButtonTextKey = "cancelButtonText"
        viewProperties.cancelButtonAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.Components.Button.Accent.Function.Label.Color.default,
            NSAttributedString.Key.font: UIFont.textM
        ]
        viewProperties.searchBar = .init(
            tintColor: state.tintColor(),
            clearImage: .ic16Close
                .withTintColor(state.iconColor())
                .withRenderingMode(.alwaysOriginal),
            searchImage: .ic16Search
                .withTintColor(state.iconColor())
                .withRenderingMode(.alwaysOriginal)
        )
        viewProperties.textField = .init(
            backgroundColor: state.backgroundColor(),
            textColor: state.textColor(),
            layerBorderColor: state.borderColor().cgColor,
            placeholder: viewProperties.textField.placeholder?
                .fontStyle(.textM)
                .alignment(.left)
                .foregroundColor(state.placeholderColor()),
            textFieldKey: "searchField",
            font: .textM,
            layerBorderWidth: 2,
            layerCornerRadius: 8
        )
    }
}

// MARK: - InputSearchStyle.State Extension

public extension InputSearchStyle.State {
    
    func tintColor() -> UIColor { .Components.InputSearch.Border.Color.active }
    
    func iconColor() -> UIColor {
        switch self {
        case .default: .Components.InputSearch.Icon.Color.default
        case .active: .Components.InputSearch.Icon.Color.active
        }
    }
    
    func backgroundColor() -> UIColor {
        switch self {
        case .default: .Components.InputSearch.Background.Color.default
        case .active: .Components.InputSearch.Background.Color.active
        }
    }
    
    func textColor() -> UIColor {
        switch self {
        case .default: .Components.InputSearch.Content.Color.default
        case .active: .Components.InputSearch.Content.Color.active
        }
    }
    
    func borderColor() -> UIColor {
        switch self {
        case .default: .Components.InputSearch.Border.Color.default
        case .active: .Components.InputSearch.Border.Color.active
        }
    }
    
    func placeholderColor() -> UIColor {
        switch self {
        case .default: .Components.InputSearch.Placeholder.Color.default
        case .active: .Components.InputSearch.Placeholder.Color.active
        }
    }
}
