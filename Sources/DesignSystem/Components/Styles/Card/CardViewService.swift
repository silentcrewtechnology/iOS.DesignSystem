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
        
        if let newStack {
            createStackCardView(from: newStack)
        }
        
        style.update(
            viewProperties: &viewProperties,
            backgroundImage: backgroundImage,
            maskedCardNumber: maskedNumber,
            newSet: newSet,
            newSize: newSize,
            newStack: newStack
        )
        view.update(with: viewProperties)
    }
    
    // MARK: - Private methods
    
    private func createStackCardView(from stack: CardViewStyle.Stack) {
        switch stack {
        case .false: viewProperties.stackCardView = nil
        case .true(var stackCardViewProperties):
            /// Не можем использовать CardViewService, так как
            /// stackCardView по сути без стиля, просто вью с
            /// картинкой и размером
            stackCardViewProperties.containerInsets = .zero
            stackCardViewProperties.size = style.stackCardSize()
            stackCardViewProperties.cornerRadius = style.stackCardCornerRadius()
            stackCardViewProperties.paymentSystemImage = nil
            
            let stackCardView = CardView()
            stackCardView.update(with: stackCardViewProperties)
            stackCardView.alpha = 0.4
            
            viewProperties.stackCardView = .init(
                stackCards: [stackCardView],
                insets: style.stackCardInsets()
            )
        }
    }
}
