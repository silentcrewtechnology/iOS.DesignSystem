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
        viewProperties: inout LoaderView.ViewProperties
    ) {
        if let newColor {
            color = newColor
        }
        
        if let newSize {
            size = newSize
        }
        
        viewProperties.frame = size.frame()
        viewProperties.rotatingAnimation = .init(animation: createRotatingAnimation())
        viewProperties.circleLayer = .init(
            strokeColor: color.strokeColor(),
            lineWidth: size.lineWidth(),
            actions: [
                "strokeEnd": NSNull(),
                "strokeStart": NSNull(),
                "transform": NSNull(),
                "strokeColor": NSNull()
            ]
        )
    }
    
    // MARK: - Private methods
    
    private func createRotatingAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = Double.pi * 2
        animation.duration = 2.2
        animation.isCumulative = true
        animation.isAdditive = true
        animation.repeatCount = Float.infinity
        
        return animation
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
        case .main: .Components.Loader.Main.Background.color
        case .accent: .Components.Loader.Accent.Background.color
        case .disabled: .Components.Loader.Disabled.Background.color
        case .primary: .Semantic.LightTheme.Static.black
        }
    }
}
