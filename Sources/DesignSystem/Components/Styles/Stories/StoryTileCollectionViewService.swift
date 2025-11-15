import UIKit
import Components

public final class StoryTileCollectionViewService: NSObject {
    
    public typealias V = StoryTileCollectionView
    public typealias Style = StoryTileCollectionViewStyle
    
    // MARK: - Properties
    
    public private(set) var view: V
    public private(set) var viewProperties: V.ViewProperties
    public private(set) var style: Style
    public private(set) var tileServices: [StoryTileViewService]
    
    // MARK: - Init
    
    public init(
        view: V = .init(),
        viewProperties: V.ViewProperties = .init(),
        style: Style = .init(),
        tileServices: [StoryTileViewService] = []
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        self.tileServices = tileServices
        super.init()
        setupView()
        update()
    }
    
    // MARK: - Methods
    
    public func update() {
        let itemSize: CGSize? = tileServices.first?.viewProperties.size
        style.update(
            itemSize: itemSize,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
    
    private func setupView() {
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.dataSource = self
        view.delegate = self
    }
}

extension StoryTileCollectionViewService: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tileServices.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        let tileView = tileServices[indexPath.row].view
        cell.contentView.addSubview(tileView)
        tileView.snp.makeConstraints { $0.edges.equalToSuperview().priority(999) }
        return cell
    }
}

extension StoryTileCollectionViewService: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        tileServices[indexPath.row].viewProperties.onTap()
    }
}
