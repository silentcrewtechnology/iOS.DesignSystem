import UIKit
import Components
import Colors

public final class TileViewService {
    
    // MARK: - Properties
    
    public private(set) var view: TileView
    public private(set) var viewProperties: TileView.ViewProperties
    public private(set) var style: TileViewStyle
    public private(set) var imageViewService = ImageViewService(
        style: .init(type: .icon(.init()), color: .main, size: .medium)
    )
    
    // MARK: - Init
    
    public init(
        view: TileView = .init(),
        viewProperties: TileView.ViewProperties = .init(),
        style: TileViewStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        
        self.viewProperties.imageView = imageViewService.view
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newBackground: TileViewStyle.Background? = nil,
        newSize: TileViewStyle.Size? = nil,
        newText: NSMutableAttributedString? = nil,
        newOnTap: (() -> Void)? = nil
    ) {
        if let newBackground {
            updateImageViewService(with: newBackground)
        }
        
        if let newText {
            viewProperties.text = newText
        }
        
        if let newOnTap {
            viewProperties.onTap = newOnTap
        }
        
        style.update(
            background: newBackground,
            size: newSize,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
    
    // MARK: - Private methods
    
    private func updateImageViewService(with background: TileViewStyle.Background) {
        viewProperties.imageView = imageViewService.view
        switch background {
        case .primary: imageViewService.update(newColor: .main)
        case .main: imageViewService.update(newColor: .primary)
        case .transparency: imageViewService.view.backgroundColor = .clear
        case .square(let image):
            let imageView = UIImageView(image: image)
            imageView.backgroundColor = .Semantic.LightTheme.Background.Base.overlay
            viewProperties.imageView = imageView
        }
    }
}
