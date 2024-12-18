import UIKit
import Components

public final class StepperViewService {
    
    // MARK: - Properties
    
    public private(set) var view: StepperView
    public private(set) var viewProperties: StepperView.ViewProperties
    public private(set) var style: StepperViewStyle
    public private(set) var itemsServices: [StepperItemViewService] = []
    private var previousSelectedIndex: Int = .zero
    
    // MARK: - Init
    
    public init(
        view: StepperView = .init(),
        viewProperties: StepperView.ViewProperties = .init(),
        itemsServices: [StepperItemViewService] = [],
        style: StepperViewStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.itemsServices = itemsServices
        self.style = style
        
        setupItems(with: .zero)
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newSelectedIndex: Int? = nil,
        newItemsServices: [StepperItemViewService]? = nil
    ) {
        if let newItemsServices {
            itemsServices = newItemsServices
        }
        
        setupItems(with: newSelectedIndex ?? self.previousSelectedIndex)
        style.update(
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
    
    // MARK: - Private methods
    
    private func setupItems(with newSelectedIndex: Int) {
        var items = [UIView]()
        var time: CGFloat = .zero
        let startIndex: Int = newSelectedIndex > previousSelectedIndex ? previousSelectedIndex : newSelectedIndex
        var needUpdateAllItems = false
        if viewProperties.itemViews.count != itemsServices.count {
            needUpdateAllItems = true
        }
        for itemIndex in 0..<itemsServices.count {
            guard needUpdateAllItems || itemIndex >= startIndex else {
                items.append(itemsServices[itemIndex].view)
                continue
            }
            
            if itemIndex < newSelectedIndex {
                Timer.scheduledTimer(withTimeInterval: time, repeats: false) { _ in
                    self.itemsServices[itemIndex].update(newState: .success)
                }
            } else if itemIndex == newSelectedIndex {
                Timer.scheduledTimer(withTimeInterval: time, repeats: false) { _ in
                    self.itemsServices[itemIndex].update(newState: .current)
                }
            } else {
                itemsServices[itemIndex].update(newState: .next)
            }
            items.append(itemsServices[itemIndex].view)
            time += 0.4 // Время анимации в StepperItemView
        }
        
        self.previousSelectedIndex = newSelectedIndex
        viewProperties.itemViews = items
    }
}
