import UIKit
import Components

public final class StoryTileCollectionViewStyle {
    
    private var itemSize: CGSize = .zero
    
    public init() { }
    
    public func update(
        itemSize: CGSize? = nil,
        viewProperties: inout StoryTileCollectionView.ViewProperties
    ) {
        if let itemSize { self.itemSize = itemSize }
        viewProperties.height = self.itemSize.height
        viewProperties.flowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 8
            layout.scrollDirection = .horizontal
            layout.itemSize = self.itemSize
            return layout
        }()
    }
}
