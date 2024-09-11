//
//  CardViewService.swift
//  
//
//  Created by user on 11.09.2024.
//

import UIKit
import Components

public final class CardViewService {
    
    // MARK: - Properties
    
    public private(set) var view: CardView
    public private(set) var viewProperties: CardView.ViewProperties
    public private(set) var style: CardViewStyle
    
    // MARK: - Life cycle
    
    public init(
        view: CardView = .init(),
        viewProperties: CardView.ViewProperties = .init(),
        style: CardViewStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newSet: CardViewStyle.Set? = nil,
        newSize: CardViewStyle.Size? = nil,
        newStack: CardViewStyle.Stack? = nil,
        newBackgroundImage: UIImage? = nil,
        newMaskedCardNumber: NSMutableAttributedString? = nil
    ) {
        let maskedNumber = newMaskedCardNumber ?? viewProperties.maskedCardNumber
        let backgroundImage = newBackgroundImage ?? viewProperties.backgroundImage
        
        style.update(
            viewProperties: &viewProperties,
            backgroundImage: backgroundImage,
            maskedCardNumber: maskedNumber,
            newSet: newSet, newSize: newSize,
            newStack: newStack
        )
        view.update(with: viewProperties)
    }
}
