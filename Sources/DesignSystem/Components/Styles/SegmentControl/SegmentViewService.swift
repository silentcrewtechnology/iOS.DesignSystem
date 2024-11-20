import UIKit
import Components

public final class SegmentControlViewService {
    
    // MARK: - Properties
    
    public private(set) var view: SegmentControlView
    public private(set) var viewProperties: SegmentControlView.ViewProperties
    public private(set) var style: SegmentControlViewStyle
    public private(set) var itemsServices: [SegmentItemViewService] = []
    private var selectedIndex: Int = .zero
    
    // MARK: - Init
    
    public init(
        view: SegmentControlView = .init(),
        viewProperties: SegmentControlView.ViewProperties = .init(),
        itemsServices: [SegmentItemViewService] = [],
        style: SegmentControlViewStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.itemsServices = itemsServices
        self.style = style
        
        setupItems()
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        background: SegmentControlViewStyle.Background? = nil,
        size: SegmentControlViewStyle.Size? = nil
    ) {
        if let size {
            makeEqualSizeToItems(size)
        }
        
        style.update(
            background: background,
            size: size,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
    
    // MARK: - Private methods
    
    private func makeEqualSizeToItems(_ size: SegmentControlViewStyle.Size) {
        for itemsService in itemsServices {
            itemsService.update(newSize: size == .small ? .sizeS : .sizeL)
        }
    }
    
    private func setupItems() {
        itemsServices.first?.update(newSelected: .true)
        var items = [UIView]()
        for itemIndex in itemsServices.indices {
            itemsServices[itemIndex].update(
                newShowDivider: getShowDivider(firstIndex: .zero, secondIndex: itemIndex),
                newHandlePress: { [weak self] state in
                    guard state == .pressed,
                          let self,
                          self.selectedIndex != itemIndex
                    else { return }
                    
                    self.itemsServices[itemIndex].viewProperties.onItemTap(state == .pressed)
                    for index in self.itemsServices.indices {
                        if index == itemIndex {
                            self.selectedIndex = index
                        }
                        self.itemsServices[index].update(
                            newSelected: index == itemIndex ? .true : .false,
                            newShowDivider: self.getShowDivider(firstIndex: itemIndex, secondIndex: index)
                        )
                    }
                }
            )
            items.append(itemsServices[itemIndex].view)
        }
        viewProperties.itemViews = items
    }
    
    private func getShowDivider(firstIndex: Int, secondIndex: Int) -> SegmentItemViewStyle.ShowDivider {
        if (secondIndex + 1) == firstIndex
            || secondIndex == firstIndex
            || (secondIndex + 1) == itemsServices.count
        {
            return .false
        }
        
        return .true
    }
}
