//
//  PaperViewStyle.swift
//
//
//  Created by Ilnur Mugaev on 03.12.2023.
//

import UIKit
import Components

public enum PaperViewStyle {
    
    public enum CornerMask {
        case none
        case top
        case bottom
        case all
        case automatic(rowsInSection: Int, indexPath: IndexPath)
    }
    
    public enum CornerRadius {
        case none
        case small
        case large
        case custom(CGFloat)
    }
    
    public enum BackgroundColor {
        case main
        case primary
        case custom(UIColor)
    }
    
    public static func update(
        mask: CornerMask,
        radius: CornerRadius,
        color: BackgroundColor,
        hasShadow: Bool = false,
        viewProperties: PaperView.ViewProperties
    ) -> PaperView.ViewProperties {
        var viewProperties = viewProperties
        viewProperties = updateCornerMask(mask: mask, viewProperties: viewProperties)
        viewProperties = updateCornerRadius(radius: radius, viewProperties: viewProperties)
        viewProperties = updateBackgroundColor(color: color, viewProperties: viewProperties)
        viewProperties = updateShadow(hasShadow: hasShadow, viewProperties: viewProperties)
        return viewProperties
    }
    
    public static func updateCornerMask(
        mask: CornerMask,
        viewProperties: PaperView.ViewProperties
    ) -> PaperView.ViewProperties {
        var viewProperties = viewProperties
        switch mask {
        case .none:
            viewProperties = updateCornerRadius(radius: .none, viewProperties: viewProperties)
        case .top:
            viewProperties.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .bottom:
            viewProperties.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .all:
            viewProperties.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case let .automatic(rowsInSection, indexPath):
            viewProperties = updateAutomaticCornerMask(rows: rowsInSection, indexPath: indexPath, viewProperties: viewProperties)
        }
        return viewProperties
    }
    
    private static func updateAutomaticCornerMask(
        rows: Int,
        indexPath: IndexPath,
        viewProperties: PaperView.ViewProperties
    ) -> PaperView.ViewProperties {
        let automaticStyle: CornerMask
        switch (rows, indexPath.row) {
        case (1, _):
            automaticStyle = .all
        case (_, 0):
            automaticStyle = .top
        case (_, let row) where row == rows - 1:
            automaticStyle = .bottom
        default:
            automaticStyle = .none
        }
        return updateCornerMask(mask: automaticStyle, viewProperties: viewProperties)
    }
    
    public static func updateCornerRadius(
        radius: CornerRadius,
        viewProperties: PaperView.ViewProperties
    ) -> PaperView.ViewProperties {
        var viewProperties = viewProperties
        switch radius {
        case .none:
            viewProperties.cornerRadius = 0
        case .small:
            viewProperties.cornerRadius = 8
        case .large:
            viewProperties.cornerRadius = 12
        case .custom(let cornerRadius):
            viewProperties.cornerRadius = cornerRadius
        }
        return viewProperties
    }
    
    public static func updateBackgroundColor(
        color: BackgroundColor,
        viewProperties: PaperView.ViewProperties
    ) -> PaperView.ViewProperties {
        var viewProperties = viewProperties
        switch color {
        case .main:
            viewProperties.backgroundColor = .backgroundMain
        case .primary:
            viewProperties.backgroundColor = .backgroundPrimary
        case .custom(let backgroundColor):
            viewProperties.backgroundColor = backgroundColor
        }
        return viewProperties
    }
    
    public static func updateShadow(
        hasShadow: Bool,
        viewProperties: PaperView.ViewProperties
    ) -> PaperView.ViewProperties {
        var viewProperties = viewProperties
        if hasShadow {
            viewProperties.masksToBounds = false
            viewProperties.shadow = .init(
                color: .black.withAlphaComponent(0.08),
                offset: .init(width: 0, height: 8),
                opacity: 1,
                radius: 16)
        } else {
            viewProperties.masksToBounds = true
            viewProperties.shadow = .init(
                color: .clear,
                offset: .zero,
                opacity: 0,
                radius: 0)
        }
        return viewProperties
    }
}
