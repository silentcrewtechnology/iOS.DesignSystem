//
//  BadgeStyle.swift
//  
//
//  Created by firdavs on 16.08.2023.
//

import Foundation
import Components

public enum BadgeStyle {
    case `default`
    case action
    case neutral
    
    func apply(
        with viewProperties: BadgeView.ViewProperties
    ) -> BadgeView.ViewProperties {
        var viewProperties = viewProperties
        switch self {
        case .default:
            viewProperties.text = viewProperties.text?.string.textS_1(color: .contentActionOn)
            viewProperties.backgroundColor = .contentError
           return viewProperties
            
        case .action:
            viewProperties.text = viewProperties.text?.string.textS_1(color: .contentActionOn)
            viewProperties.backgroundColor = .backgroundSuccess
           return viewProperties
            
        case .neutral:
            viewProperties.text = viewProperties.text?.string.textS_1(color: .contentActionOn)
            viewProperties.backgroundColor = .backgroundMainInverse
           return viewProperties
    
        }
    }
}
