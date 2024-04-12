//
//  PaperViewStyle.swift
//
//
//  Created by Ilnur Mugaev on 03.12.2023.
//

import UIKit
import Components

public struct PaperViewStyle {
    
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
    
    private var mask: CornerMask
    private var radius: CornerRadius
    private var color: BackgroundColor
    private var hasShadow: Bool
    
    public init(
        mask: CornerMask,
        radius: CornerRadius,
        color: BackgroundColor,
        hasShadow: Bool
    ) {
        self.mask = mask
        self.radius = radius
        self.color = color
        self.hasShadow = hasShadow
    }
    
    public func update(
        viewProperties: inout PaperView.ViewProperties
    ) {
        updateCornerMask(mask: mask, viewProperties: &viewProperties)
        updateCornerRadius(viewProperties: &viewProperties)
        updateBackgroundColor(viewProperties: &viewProperties)
        updateShadow(viewProperties: &viewProperties)
    }
    
    private func updateCornerMask(
        mask: CornerMask,
        viewProperties: inout PaperView.ViewProperties
    ) {
        switch mask {
        case .none:
            updateCornerRadius(viewProperties: &viewProperties)
        case .top:
            viewProperties.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .bottom:
            viewProperties.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .all:
            viewProperties.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case let .automatic(rowsInSection, indexPath):
            updateAutomaticCornerMask(rows: rowsInSection, indexPath: indexPath, viewProperties: &viewProperties)
        }
    }
    
    private func updateAutomaticCornerMask(
        rows: Int,
        indexPath: IndexPath,
        viewProperties: inout PaperView.ViewProperties
    ) {
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
        updateCornerMask(mask: automaticStyle, viewProperties: &viewProperties)
    }
    
    private func updateCornerRadius(
        viewProperties: inout PaperView.ViewProperties
    ) {
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
    }
    
    private func updateBackgroundColor(
        viewProperties: inout PaperView.ViewProperties
    ) {
        switch color {
        case .main:
            viewProperties.backgroundColor = .backgroundMain
        case .primary:
            viewProperties.backgroundColor = .backgroundPrimary
        case .custom(let backgroundColor):
            viewProperties.backgroundColor = backgroundColor
        }
    }
    
    private func updateShadow(
        viewProperties: inout PaperView.ViewProperties
    ) {
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
    }
}
