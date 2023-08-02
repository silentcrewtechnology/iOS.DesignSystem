//
//  SectionMessageStyle.swift
//  
//
//  Created by firdavs on 13.06.2023.
//

import Foundation
import ImagesService
import ColorService
import UIKit

public enum SectionMessageStyle {
    case info
    case warning
    case success
    case error
    case security
    case none
    
    public func applay(
        with viewProperties: inout SectionMessageView.ViewProperties?
    ) -> SectionMessageView.ViewProperties? {
        guard var viewProperties = viewProperties else { return nil }
        switch self {
        case .info:
            viewProperties.title = viewProperties.title?.string.textM_1(color: .contentPrimary)
            viewProperties.content = viewProperties.content?.string.textM_1(color: .contentPrimary)
            viewProperties.subtitle = viewProperties.subtitle?.string.textM_1(color: .contentInfo)
            viewProperties.iconImage = ImagesService.infoCircleOutline.tinted(with: .contentInfo)
            viewProperties.backgroundColor = .backgroundInfoLight
           return viewProperties
            
        case .warning:
            viewProperties.title =  viewProperties.title?.string.textM_1(color: .contentPrimary)
            viewProperties.content = viewProperties.content?.string.textM_1(color: .contentPrimary)
            viewProperties.subtitle = viewProperties.subtitle?.string.textM_1(color: .contenWarning)
            viewProperties.iconImage = ImagesService.warningTriangleOutline.tinted(with: .contenWarning)
            viewProperties.backgroundColor = .backgroundWarningLight
           return viewProperties
            
        case .success:
            viewProperties.title = viewProperties.title?.string.textM_1(color: .contentPrimary)
            viewProperties.content = viewProperties.content?.string.textM_1(color: .contentPrimary)
            viewProperties.subtitle = viewProperties.subtitle?.string.textM_1(color: .contentSuccess)
            viewProperties.iconImage = ImagesService.checkCircleOutline.tinted(with: .contentSuccess)
            viewProperties.backgroundColor = .backgroundSuccessLight
           return viewProperties
            
        case .error:
            viewProperties.title = viewProperties.title?.string.textM_1(color: .contentPrimary)
            viewProperties.content = viewProperties.content?.string.textM_1(color: .contentPrimary)
            viewProperties.subtitle = viewProperties.subtitle?.string.textM_1(color: .contentError)
            viewProperties.iconImage = ImagesService.infoCircleOutline.tinted(with: .contentInfo)
            viewProperties.backgroundColor = .backgroundErrorLight
           return viewProperties
            
        case .security:
            viewProperties.title = viewProperties.title?.string.textM_1(color: .contentPrimary)
            viewProperties.content = viewProperties.content?.string.textM_1(color: .contentPrimary)
            viewProperties.subtitle = viewProperties.subtitle?.string.textM_1(color: .contentAction)
            viewProperties.iconImage = ImagesService.security.tinted(with: .contentInfo)
            viewProperties.backgroundColor = .backgroundSecondary
           return viewProperties
            
        case .none:
            return viewProperties
        }
    }
}

public enum TestSectionMessageStyle {
    case info
    case warning
    case success
    case error
    case security
    case none
    
    public func applay(
        with viewProperties: inout TestSectionMessageView.ViewProperties
    ) -> TestSectionMessageView.ViewProperties {
        switch self {
        case .info:
            viewProperties.title = viewProperties.title?.string.textM_1(color: .contentPrimary)
            viewProperties.content = viewProperties.content?.string.textM_1(color: .contentPrimary)
            viewProperties.subtitle = viewProperties.subtitle?.string.textM_1(color: .contentInfo)
            viewProperties.iconImage = ImagesService.infoCircleOutline.tinted(with: .contentInfo)
            viewProperties.backgroundColor = .backgroundInfoLight
           return viewProperties
            
        case .warning:
            viewProperties.title =  viewProperties.title?.string.textM_1(color: .contentPrimary)
            viewProperties.content = viewProperties.content?.string.textM_1(color: .contentPrimary)
            viewProperties.subtitle = viewProperties.subtitle?.string.textM_1(color: .contenWarning)
            viewProperties.iconImage = ImagesService.warningTriangleOutline.tinted(with: .contenWarning)
            viewProperties.backgroundColor = .backgroundWarningLight
           return viewProperties
            
        case .success:
            viewProperties.title = viewProperties.title?.string.textM_1(color: .contentPrimary)
            viewProperties.content = viewProperties.content?.string.textM_1(color: .contentPrimary)
            viewProperties.subtitle = viewProperties.subtitle?.string.textM_1(color: .contentSuccess)
            viewProperties.iconImage = ImagesService.checkCircleOutline.tinted(with: .contentSuccess)
            viewProperties.backgroundColor = .backgroundSuccessLight
           return viewProperties
            
        case .error:
            viewProperties.title = viewProperties.title?.string.textM_1(color: .contentPrimary)
            viewProperties.content = viewProperties.content?.string.textM_1(color: .contentPrimary)
            viewProperties.subtitle = viewProperties.subtitle?.string.textM_1(color: .contentError)
            viewProperties.iconImage = ImagesService.infoCircleOutline.tinted(with: .contentInfo)
            viewProperties.backgroundColor = .backgroundErrorLight
           return viewProperties
            
        case .security:
            viewProperties.title = viewProperties.title?.string.textM_1(color: .contentPrimary)
            viewProperties.content = viewProperties.content?.string.textM_1(color: .contentPrimary)
            viewProperties.subtitle = viewProperties.subtitle?.string.textM_1(color: .contentAction)
            viewProperties.iconImage = ImagesService.security.tinted(with: .contentInfo)
            viewProperties.backgroundColor = .backgroundSecondary
           return viewProperties
            
        case .none:
            return viewProperties
        }
    }
}
