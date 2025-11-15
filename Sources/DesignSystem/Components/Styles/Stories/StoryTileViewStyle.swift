import UIKit
import Components
import Colors

public final class StoryTileViewStyle {
    
    public enum State {
        case unread
        case read
    }
    
    public private(set) var state: State
    
    public init(
        state: State = .unread
    ) {
        self.state = state
    }
    
    public func update(
        state: State? = nil,
        viewProperties: inout StoryTileView.ViewProperties
    ) {
        if let state { self.state = state }
        
        viewProperties.size = size()
        
        viewProperties.border.color = self.state.borderColor()
        viewProperties.border.cornerRadius = 16
        viewProperties.border.width = 1
        
        viewProperties.title = viewProperties.title.string.attributed
            .fontStyle(.text2XS_1)
            .foregroundColor(.white)
            .alignment(.left)
            .lineBreakMode(.byTruncatingTail)
        viewProperties.titleInsets = .init(top: 6, left: 6, bottom: 6, right: 6)
        
        viewProperties.content.color = .init(white: 0, alpha: 0.5)
        viewProperties.content.cornerRadius = 12
        viewProperties.content.insets = .init(top: 4, left: 4, bottom: 4, right: 4)
        viewProperties.content.gradient.update(with: .init(
            startPoint: .init(x: 0.5, y: 0),
            endPoint: .init(x: 0.5, y: 1),
            colors: [
                UIColor(white: 0, alpha: 0.2).cgColor,
                UIColor(white: 0, alpha: 0).cgColor,
            ]
        ))
        viewProperties.content.gradientInsets = .init(top: 0, left: 0, bottom: 38, right: 0)
    }
    
    private func size() -> CGSize { .init(width: 96, height: 96) }
}

extension StoryTileViewStyle.State {
    
    public func borderColor() -> UIColor {
        switch self {
        case .unread: .Semantic.LightTheme.Border.Accent.default
        case .read: .Semantic.LightTheme.Border.Base.main
        }
    }
}
