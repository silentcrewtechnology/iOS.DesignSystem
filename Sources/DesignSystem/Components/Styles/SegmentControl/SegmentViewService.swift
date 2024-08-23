import UIKit
import Components

public final class SegmentControlViewService {
    public private(set) var view: SegmentControlView
    public var viewProperties: SegmentControlView.ViewProperties
    public private(set) var itemsProperties: [SegmentItemView.ViewProperties]
    public private(set) var style: SegmentControlViewStyle
    
    private var itemsServices: [SegmentItemViewService] = []
    
    public init(
        view: SegmentControlView = .init(),
        viewProperties: SegmentControlView.ViewProperties = .init(),
        itemsProperties: [SegmentItemView.ViewProperties] = [],
        background: SegmentControlViewStyle.Background = .primary,
        size: SegmentControlViewStyle.Size = .large
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.itemsProperties = itemsProperties
        
        self.style = SegmentControlViewStyle(
            background: background,
            size: size
        )
        createItems(size: size)
        setupItemViews()
        update()
    }
    
    public func update(
        background: SegmentControlViewStyle.Background? = nil,
        size: SegmentControlViewStyle.Size? = nil
    ) {
        self.style.update(background: background,
                          size: size,
                          viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
}

// MARK: Setup Properties

extension SegmentControlViewService {
    private func createItems(size: SegmentControlViewStyle.Size) {
        for index in itemsProperties.indices {
            setupItemAction(index: index)
            
            let itemService = SegmentItemViewService(
                viewProperties: itemsProperties[index],
                size: getSize(size: size),
                selected: index == viewProperties.selectedSegmentIndex ? .true : .false,
                showDivider: getShowDivider(index: index)
            )
            
            itemsServices.append(itemService)
        }
    }
    
    private func getShowDivider(index: Int) -> SegmentItemViewStyle.ShowDivider {
        if (index + 1) == self.viewProperties.selectedSegmentIndex ||
            index == self.viewProperties.selectedSegmentIndex ||
            (index + 1) == self.itemsProperties.count
        {
            return .false
        }
        return .true
    }
    
    private func getSize(size: SegmentControlViewStyle.Size) -> SegmentItemViewStyle.Size {
        let itemSize: SegmentItemViewStyle.Size
        switch size {
        case .large:
            itemSize = .sizeL
        case .small:
            itemSize = .sizeS
        }
        return itemSize
    }
    
    private func setupItemViews() {
        for service in itemsServices {
            viewProperties.itemViews.append(service.view)
        }
    }
    
    private func setupItemAction(index: Int) {
        let onItemTap = itemsProperties[index].onItemTap
        itemsProperties[index].onItemTap = { [weak self] isSelected in
            guard isSelected,
                  let self
            else { return }
            onItemTap(isSelected)
            
            if isSelected {
                self.viewProperties.selectedSegmentIndex = index
            }
            
            for index in self.itemsServices.indices {
                
                let selected: SegmentItemViewStyle.Selected
                selected = index == self.viewProperties.selectedSegmentIndex ? .true : .false
                
                self.itemsServices[index].update(
                    state: .default,
                    selected: selected,
                    showDivider: self.getShowDivider(index: index))
            }
        }
    }
}

