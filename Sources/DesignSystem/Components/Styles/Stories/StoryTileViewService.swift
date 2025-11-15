import UIKit
import Components

public final class StoryTileViewService {
    
    public typealias V = StoryTileView
    public typealias Style = StoryTileViewStyle
    
    // MARK: - Properties
    
    public private(set) var view: V
    public private(set) var viewProperties: V.ViewProperties
    public private(set) var style: Style
    
    // MARK: - Init
    
    public init(
        view: V = .init(),
        viewProperties: V.ViewProperties = .init(),
        style: Style = .init(state: .unread)
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newState: Style.State? = nil,
        newImage: UIImage? = nil,
        newOnTap: (() -> Void)? = nil
    ) {
        if let newOnTap { viewProperties.onTap = newOnTap }
        if let newImage { viewProperties.content.image = newImage }
        style.update(
            state: newState,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
}
