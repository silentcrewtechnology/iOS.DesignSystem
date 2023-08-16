//
//  BadgeStyle.swift
//  
//
//  Created by firdavs on 16.08.2023.
//

import Foundation

public enum BadgeStyle {
    case `default`
    case action
    case neutral
    
    public func applay(
        with viewProperties: inout BadgeView.ViewProperties
    ) -> BadgeView.ViewProperties {
        switch self {
        case .default:
            viewProperties.text = viewProperties.text?.string.textM_1(color: .contentPrimary)
            viewProperties.backgroundColor = .contentError
           return viewProperties
            
        case .action:
            viewProperties.text = viewProperties.text?.string.textM_1(color: .contentPrimary)
            viewProperties.backgroundColor = .backgroundSuccess
           return viewProperties
            
        case .neutral:
            viewProperties.text = viewProperties.text?.string.textM_1(color: .contentPrimary)
            viewProperties.backgroundColor = .backgroundMainInverse
           return viewProperties
    
        }
    }
}
