//
//  SnackBarViewStyle.swift
//  
//
//  Created by Ilnur Mugaev on 27.03.2024.
//

import UIKit
import Components

public struct SnackBarViewStyle {
    
    public enum Variant {
        case success
        case info
        case warning
        case error
    }
    
    public enum Color {
        case light
        case dark
    }
    
    public enum Delay {
        case short
        case long
        case infinite
        case custom(TimeInterval)
    }
    
    private let color: Color
    private let variant: Variant
    private let delay: Delay
    
    public init(
        color: Color,
        variant: Variant,
        delay: Delay
    ) {
        self.color = color
        self.variant = variant
        self.delay = delay
    }
    
    public func update(
        viewProperties: inout SnackBarView.ViewProperties
    ) {
        let foregroundColors = color.foregroundColors()
        
        viewProperties.icon = variant.icon()
        viewProperties.title = viewProperties.title?.fontStyle(.textM_1).foregroundColor(foregroundColors.title)
        viewProperties.content = viewProperties.content?.fontStyle(.textS).foregroundColor(foregroundColors.content)
        viewProperties.closeButton?.icon = .ic16Close.tinted(with: color.closeButtonIconTintColor())
        viewProperties.backgroundColor = color.backgroundColor()
        
        updateBottomButton(to: &viewProperties)
        updateShadow(to: &viewProperties)
        updateAnimations(to: &viewProperties)
    }
    
    private func updateBottomButton(
        to viewProperties: inout SnackBarView.ViewProperties
    ) {
        guard let bottomButton = viewProperties.bottomButton else { return }
        viewProperties.bottomButton?.title = bottomButton.title
            .fontStyle(.textXS)
            .foregroundColor(color.foregroundColors().bottomButtonTitle)
    }
    
    private func updateShadow(
        to viewProperties: inout SnackBarView.ViewProperties
    ) {
        viewProperties.shadow = .init(
            color: UIColor.snackBarShadow.cgColor,
            offset: .init(width: 0, height: 4),
            radius: 20,
            opacity: 1.0
        )
    }
    
    private func updateAnimations(
        to viewProperties: inout SnackBarView.ViewProperties
    ) {
        viewProperties.animationIn = .init(
            duration: 0.4,
            delay: 0.1,
            options: .curveEaseOut,
            showTime: delay.showTime()
        )
        
        viewProperties.animationOut = .init(
            duration: 0.4,
            delay: .zero,
            options: .curveLinear,
            showTime: delay.showTime()
        )
    }
}

public extension SnackBarViewStyle.Color {
    
    func backgroundColor() -> UIColor {
        switch self {
        case .light: .backgroundMain
        case .dark: .backgroundMainInverse
        }
    }
    
    func closeButtonIconTintColor() -> UIColor {
        switch self {
        case .light: .contentPrimary
        case .dark: .contentPrimaryInverse
        }
    }
    
    func foregroundColors() -> (
        title: UIColor,
        content: UIColor,
        bottomButtonTitle: UIColor
    ) {
        switch self {
        case .light:
            return (
                title: .contentPrimary,
                content: .contentSecondary,
                bottomButtonTitle: .contentAction
            )
        case .dark:
            return (
                title: .contentPrimaryInverse,
                content: .contentPrimaryInverse,
                bottomButtonTitle: .contentAction
            )
        }
    }
}

public extension SnackBarViewStyle.Variant {
    
    func icon() -> UIImage {
        switch self {
        case .success: .ic24CheckCircleFilled.tinted(with: .backgroundSuccess)
        case .info: .ic24InfoCircleFilled.tinted(with: .contentInfo)
        case .warning: .ic24WarningCircleFilled.tinted(with: .contentWarning)
        case .error: .ic24WarningCircleFilled.tinted(with: .contentError)
        }
    }
}

public extension SnackBarViewStyle.Delay {
    
    func showTime() -> TimeInterval {
        switch self {
        case .short: 3.0
        case .long: 5.0
        case .infinite: .infinity
        case .custom(let interval): interval
        }
    }
}
