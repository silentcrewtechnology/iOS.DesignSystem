//
//  TitleViewStyle.swift
//
//
//  Created by Ilnur Mugaev on 01.04.2024.
//

import UIKit
import Components
import Colors

public final class TitleViewStyle {
    
    // MARK: - Properties
    
    public enum Size {
        case extraLarge
        case large
        case medium
        case small
    }
    
    public enum Color {
        case primary
        case secondary
    }
    
    // MARK: - Private properties
    
    private var size: Size
    private var color: Color
    
    // MARK: - Life cycle
    
    public init(
        size: Size,
        color: Color
    ) {
        self.size = size
        self.color = color
    }
    
    // MARK: - Methods
    
    public func update(
        newSize: Size? = nil,
        newTitleColor: Color? = nil,
        viewProperties: inout TitleView.ViewProperties
    ) {
        if let newSize { size = newSize }
        if let newTitleColor { color = newTitleColor }
        viewProperties.title = viewProperties.title
            .fontStyle(size.titleFontStyle())
            .foregroundColor(color.titleColor())
            .alignment(.left)
        viewProperties.description = viewProperties.description
            .fontStyle(size.descriptionFontStyle())
            .foregroundColor(color.descriptionColor())
            .alignment(.left)
        viewProperties.insets = .init(top: 16, left: 16, bottom: 8, right: 16)
    }
    
    /// Для передачи в дочерний ``ButtonIconService``
    func buttonIconSize() -> ButtonIconStyle.Size { .small }
}

private extension TitleViewStyle.Size {
    
    func titleFontStyle() -> FontStyle {
        switch self {
        case .extraLarge: .textXL_1
        case .large: .textL_1
        case .medium: .textM_1
        case .small: .textS_1
        }
    }
    
    func descriptionFontStyle() -> FontStyle {
        switch self {
        case .extraLarge: .textM
        case .large: .textM
        case .medium: .textS
        case .small: .textXS // нет в макете
        }
    }
}

private extension TitleViewStyle.Color {
    
    func titleColor() -> UIColor {
        switch self {
        case .primary: .Semantic.LightTheme.Content.Base.primary
        case .secondary: .Semantic.LightTheme.Content.Base.secondary
        }
    }
    
    func descriptionColor() -> UIColor {
        switch self {
        case .primary: .Semantic.LightTheme.Content.Base.secondary
        case .secondary: .Semantic.LightTheme.Content.Base.tertiary
        }
    }
}
