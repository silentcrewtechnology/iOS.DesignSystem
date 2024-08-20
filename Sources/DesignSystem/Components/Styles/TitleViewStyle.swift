//
//  TitleViewStyle.swift
//
//
//  Created by Ilnur Mugaev on 01.04.2024.
//

import UIKit
import Components
import Colors

public struct TitleViewStyle {
    
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
    
    private let size: Size
    private let color: Color
    
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
        viewProperties: inout TitleView.ViewProperties
    ) {
        viewProperties.title = viewProperties.title
            .fontStyle(size.titleFontStyle())
            .foregroundColor(color == .primary
                            ? .Semantic.LightTheme.Content.Base.primary
                            : .Semantic.LightTheme.Content.Base.secondary
            )
        viewProperties.insets = .init(top: 16, left: 16, bottom: 8, right: 16)
    }
}

public extension TitleViewStyle.Size {
    func titleFontStyle() -> DesignSystem.FontStyle {
        switch self {
        case .extraLarge: .textXL_1
        case .large: .textL_1
        case .medium: .textM_1
        case .small: .textS_1
        }
    }
}
