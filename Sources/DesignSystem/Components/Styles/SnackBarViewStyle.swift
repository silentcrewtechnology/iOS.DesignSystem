//
//  SnackBarViewStyle.swift
//  
//
//  Created by Ilnur Mugaev on 27.03.2024.
//

import UIKit
import Components

public struct SnackBarViewStyle {
    
    // MARK: - Properties
    
    public enum Variant {
        case info
        case success
        case warning
        case error
    }
    
    public enum Delay {
        case short
        case long
        case infinite
        case custom(TimeInterval)
        
        func showTime() -> TimeInterval {
            switch self {
            case .short: 3.0
            case .long: 5.0
            case .infinite: .infinity
            case .custom(let interval): interval
            }
        }
    }
    
    // MARK: - Private proeprties
    
    private let variant: Variant
    private let delay: Delay
    
    // MARK: - Life cycle
    
    public init(
        variant: Variant,
        delay: Delay
    ) {
        self.variant = variant
        self.delay = delay
    }
    
    // MARK: - Methods
    
    public func update(
        viewProperties: inout SnackBarView.ViewProperties
    ) {
        viewProperties.icon = .init(image: variant.icon(), size: .init(width: 24, height: 24))
        viewProperties.title = viewProperties.title?.fontStyle(.textM_1).foregroundColor(variant.titleTintColor())
        viewProperties.subtitle = viewProperties.subtitle?.fontStyle(.textS).foregroundColor(variant.subtitleTintColor())
        viewProperties.closeButton?.icon = .ic16Close.withTintColor(variant.closeIconTintColor())
        viewProperties.closeButton?.size = .init(width: 16, height: 24)
        viewProperties.backgroundColor = variant.backgroundTintColor()
        viewProperties.cornerRadius = 12
        viewProperties.height = 100
        viewProperties.stackViewInsets = .init(inset: 16)
        viewProperties.containerViewInsets = .init(inset: 16)
        viewProperties.spacerViewProperties = .init(size: .init(width: .zero, height: 8))
        viewProperties.animationInsets = .zero
        
        updateBottomButton(to: &viewProperties)
        updateShadow(to: &viewProperties)
        updateAnimations(to: &viewProperties)
    }
    
    // MARK: - Private methods
    
    private func updateBottomButton(
        to viewProperties: inout SnackBarView.ViewProperties
    ) {
        guard let bottomButton = viewProperties.bottomButton else { return }
        
        viewProperties.bottomButton?.title = bottomButton.title
            .fontStyle(.textXS)
            .foregroundColor(variant.bottomButtonTintColor())
    }
    
    private func updateShadow(
        to viewProperties: inout SnackBarView.ViewProperties
    ) {
        viewProperties.shadow = .init(
            color: UIColor.Core.Brand.neutral1000.cgColor,
            offset: .init(width: 0, height: 4),
            radius: 20,
            opacity: 0.06
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

// MARK: - SnackBarViewStyle.Variant Extension

public extension SnackBarViewStyle.Variant {
    
    func icon() -> UIImage {
        switch self {
        case .info: .ic24InfoCircleFilled.withTintColor(.Components.Snackbar.Info.IconLeft.Color.default)
        case .success: .ic24CheckCircleFilled.withTintColor(.Components.Snackbar.Success.IconLeft.Color.default)
        case .warning: .ic24WarningTriangleFilled.withTintColor(.Components.Snackbar.Warning.IconLeft.Color.default)
        case .error: .ic24WarningCircleFilled.withTintColor(.Components.Snackbar.Error.IconLeft.Color.default)
        }
    }
    
    func titleTintColor() -> UIColor {
        switch self {
        case .info: .Components.Snackbar.Info.Title.Color.default
        case .success: .Components.Snackbar.Success.Title.Color.default
        case .warning: .Components.Snackbar.Warning.Title.Color.default
        case .error: .Components.Snackbar.Error.Title.Color.default
        }
    }
    
    func subtitleTintColor() -> UIColor {
        switch self {
        case .info: .Components.Snackbar.Info.Subtitle.Color.default
        case .success: .Components.Snackbar.Success.Subtitle.Color.default
        case .warning: .Components.Snackbar.Warning.Subtitle.Color.default
        case .error: .Components.Snackbar.Error.Subtitle.Color.default
        }
    }
    
    func bottomButtonTintColor() -> UIColor {
        switch self {
        case .info: .Components.Snackbar.Info.ButtonLabel.Color.default
        case .success: .Components.Snackbar.Success.ButtonLabel.Color.default
        case .warning: .Components.Snackbar.Warning.ButtonLabel.Color.default
        case .error: .Components.Snackbar.Error.ButtonLabel.Color.default
        }
    }
    
    func closeIconTintColor() -> UIColor {
        switch self {
        case .info: .Components.Snackbar.Info.IconClose.Color.default
        case .success: .Components.Snackbar.Success.IconClose.Color.default
        case .warning: .Components.Snackbar.Warning.IconClose.Color.default
        case .error: .Components.Snackbar.Error.IconClose.Color.default
        }
    }
    
    func backgroundTintColor() -> UIColor {
        switch self {
        case .info: .Components.Snackbar.Info.Background.Color.default
        case .success: .Components.Snackbar.Success.Background.Color.default
        case .warning: .Components.Snackbar.Warning.Background.Color.default
        case .error: .Components.Snackbar.Error.Background.Color.default
        }
    }
}
