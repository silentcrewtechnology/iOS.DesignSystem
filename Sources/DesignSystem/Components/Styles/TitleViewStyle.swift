//
//  TitleViewStyle.swift
//
//
//  Created by Ilnur Mugaev on 01.04.2024.
//

import UIKit
import Components

public struct TitleViewStyle {
    
    public enum Variant {
        case `default`
        case compressed
    }
    
    public enum Size {
        case size2XL
        case sizeXL
        case sizeL
        case sizeM
        case sizeS
    }
    
    private let variant: Variant
    private let size: Size
    
    public init(
        variant: Variant,
        size: Size
    ) {
        self.variant = variant
        self.size = size
    }
    
    public func update(
        viewProperties: inout TitleView.ViewProperties
    ) {
        
        viewProperties.title = viewProperties.title
            .fontStyle(size.titleFontStyle())
            .foregroundColor(.contentPrimary)
        
        viewProperties.description = viewProperties.description?
            .fontStyle(.textM)
            .foregroundColor(.contentSecondary)
        
        viewProperties.insets = variant.insets(size: size)
        viewProperties.space = variant == .default ? 8 : 4
    }
}

public extension TitleViewStyle.Variant {
    
    func insets(
        size: TitleViewStyle.Size
    ) -> UIEdgeInsets {
        switch self {
        case .default: defaultInsets(size: size)
        case .compressed: compressedInsets(size: size)
        }
    }
    
    private func defaultInsets(
        size: TitleViewStyle.Size
    ) -> UIEdgeInsets {
        switch size {
        case .size2XL:
            return .init(top: 24, left: 16, bottom: 16, right: 16)
        case .sizeXL:
            return .init(top: 20, left: 16, bottom: 12, right: 16)
        case .sizeL, .sizeM, .sizeS:
            return .init(top: 16, left: 16, bottom: 8, right: 16)
        }
    }
    
    private func compressedInsets(
        size: TitleViewStyle.Size
    ) -> UIEdgeInsets {
        switch size {
        case .size2XL:
            return .init(top: 16, left: 16, bottom: 16, right: 16)
        case .sizeXL:
            return .init(top: 12, left: 16, bottom: 12, right: 16)
        case .sizeL:
            return .init(top: 8, left: 16, bottom: 8, right: 16)
        case .sizeM, .sizeS:
            return .init(top: 6, left: 16, bottom: 2, right: 16)
        }
    }
}

public extension TitleViewStyle.Size {
    
    func titleFontStyle() -> FontStyle {
        switch self {
        case .size2XL: .text2XL_1
        case .sizeXL: .textXL_1
        case .sizeL: .textL_1
        case .sizeM: .textM_1
        case .sizeS: .textS_1
        }
    }
}
