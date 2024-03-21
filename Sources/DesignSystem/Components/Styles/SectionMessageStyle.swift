//
//  SectionMessageStyle.swift
//  
//
//  Created by firdavs on 13.06.2023.
//

import ImagesService
import UIKit
import Components

public enum SectionMessageStyle {
    case info
    case warning
    case success
    case error
    case security
    case none
    
    public func apply(
        with viewProperties: inout SectionMessageView.ViewProperties
    ) -> SectionMessageView.ViewProperties {
        switch self {
        case .info:
            viewProperties.title = viewProperties.title?.string.textM_1(color: .contentPrimary)
            viewProperties.content = viewProperties.content?.string.textM_1(color: .contentPrimary)
            viewProperties.subtitle = viewProperties.subtitle?.string.textM_1(color: .contentInfo)
            viewProperties.iconImage = .ic24InfoCircleOutline.tinted(with: .contentInfo)
            viewProperties.backgroundColor = .backgroundInfoLight
           return viewProperties
            
        case .warning:
            viewProperties.title =  viewProperties.title?.string.textM_1(color: .contentPrimary)
            viewProperties.content = viewProperties.content?.string.textM_1(color: .contentPrimary)
            viewProperties.subtitle = viewProperties.subtitle?.string.textM_1(color: .contentWarning)
            viewProperties.iconImage = .ic24WarningTriangleOutline.tinted(with: .contentWarning)
            viewProperties.backgroundColor = .backgroundWarningLight
           return viewProperties
            
        case .success:
            viewProperties.title = viewProperties.title?.string.textM_1(color: .contentPrimary)
            viewProperties.content = viewProperties.content?.string.textM_1(color: .contentPrimary)
            viewProperties.subtitle = viewProperties.subtitle?.string.textM_1(color: .contentSuccess)
            viewProperties.iconImage = .ic24CheckCircleOutline.tinted(with: .contentSuccess)
            viewProperties.backgroundColor = .backgroundSuccessLight
           return viewProperties
            
        case .error:
            viewProperties.title = viewProperties.title?.string.textM_1(color: .contentPrimary)
            viewProperties.content = viewProperties.content?.string.textM_1(color: .contentPrimary)
            viewProperties.subtitle = viewProperties.subtitle?.string.textM_1(color: .contentError)
            viewProperties.iconImage = .ic24InfoCircleOutline.tinted(with: .contentInfo)
            viewProperties.backgroundColor = .backgroundErrorLight
           return viewProperties
            
        case .security:
            viewProperties.title = viewProperties.title?.string.textM_1(color: .contentPrimary)
            viewProperties.content = viewProperties.content?.string.textM_1(color: .contentPrimary)
            viewProperties.subtitle = viewProperties.subtitle?.string.textM_1(color: .contentAction)
            viewProperties.iconImage = .ic24Security.tinted(with: .contentInfo)
            viewProperties.backgroundColor = .backgroundSecondary
           return viewProperties
            
        case .none:
            return viewProperties
        }
    }
}
