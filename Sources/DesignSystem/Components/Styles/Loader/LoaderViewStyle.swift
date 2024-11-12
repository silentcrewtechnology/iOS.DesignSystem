//
//  LoaderViewStyle.swift
//  
//
//  Created by user on 04.10.2024.
//

import UIKit
import Components
import Colors

public final class LoaderViewStyle {
    
    // MARK: - Properties
    
    public enum Color {
        case main
        case accent
        case disabled
        case primary
        case custom(UIColor)
    }
    
    public enum Size {
        case xl
        case l
        case m
        case s
    }
    
    // MARK: - Private properties
    
    private var color: Color
    private var size: Size
    
    // MARK: - Init
    
    public init(
        color: Color,
        size: Size
    ) {
        self.color = color
        self.size = size
    }
    
    // MARK: - Methods
    
    public func update(
        newColor: Color? = nil,
        newSize: Size? = nil,
        newLoaderAnimation: LoaderAnimation? = nil,
        viewProperties: inout LoaderView.ViewProperties
    ) {
        if let newColor {
            color = newColor
        }
        
        if let newSize {
            size = newSize
        }
        
        viewProperties.size = size.frame().size
        newLoaderAnimation?.update(
            with: .init(
                duration: Constants.duration,
                speedMultiplier: Constants.speedMultiplier,
                minArcLength: Constants.minArcLength,
                maxArcLength: Constants.maxArcLength,
                rotationAngle: Constants.rotationAngle
            )
        )
        viewProperties.animationLayer.update(
            with: .init(
                frame: size.frame(),
                strokeColor: color.strokeColor().cgColor,
                lineWidth: size.lineWidth(),
                animation: newLoaderAnimation
            )
        )
    }
}

// MARK: - LoaderViewStyle.Size

public extension LoaderViewStyle.Size {
    func frame() -> CGRect {
        switch self {
        case .xl: .init(x: .zero, y: .zero, width: 48, height: 48)
        case .l: .init(x: .zero, y: .zero, width: 32, height: 32)
        case .m: .init(x: .zero, y: .zero, width: 24, height: 24)
        case .s: .init(x: .zero, y: .zero, width: 16, height: 16)
        }
    }
    
    func lineWidth() -> CGFloat {
        switch self {
        case .xl: 4
        case .l: 3
        case .m: 2
        case .s: 1.5
        }
    }
}

// MARK: - LoaderViewStyle.Color

public extension LoaderViewStyle.Color {
    func strokeColor() -> UIColor {
        switch self {
        case .main: .Components.Loader.Main.Background.Color.color
        case .accent: .Components.Loader.Accent.Background.Color.color
        case .disabled: .Components.Loader.Disabled.Background.Color.color
        case .primary: .Components.Loader.Primary.Background.Color.color
        case .custom(let color): color
        }
    }
}

private enum Constants {
    
    static let duration: CFTimeInterval = 1.4
    static let speedMultiplier: Float = 1 // уменьшить для замедления
    static let minArcLength: CGFloat = 15 / 360
    static let maxArcLength: CGFloat = 270 / 360
    static let rotationAngle: CGFloat = .pi * 2 * (2 - Constants.maxArcLength)
}
