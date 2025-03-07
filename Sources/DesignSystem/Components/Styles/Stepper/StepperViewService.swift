import UIKit
import Components

public final class StepperViewService {
    
    // MARK: - Properties
    
    public private(set) var view: StepperView
    public private(set) var viewProperties: StepperView.ViewProperties
    public private(set) var style: StepperViewStyle
    public private(set) var itemsServices: [StepperItemViewService] = []
    private var previousSelectedIndex: Int = .zero
    private var isAnimating: Bool = false
    private var pendingNewSelectedIndex: Int?
    private let animationDelay: TimeInterval = 0.4
    
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
        guard newSelectedIndex >= 0, newSelectedIndex < itemsServices.count else {
            return
        }
        
        if isAnimating {
            pendingNewSelectedIndex = newSelectedIndex
            return
        }
        
        isAnimating = true
        var totalAnimationTime: TimeInterval = 0.0
        
        if newSelectedIndex > previousSelectedIndex {
            var delay: TimeInterval = 0.0
            for index in previousSelectedIndex...newSelectedIndex {
                let newState: StepperItemViewStyle.State = (index == newSelectedIndex) ? .current : .success
                Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
                    self.itemsServices[index].update(newState: newState)
                }
                delay += animationDelay
            }
            totalAnimationTime = delay
            
            if newSelectedIndex < itemsServices.count - 1 {
                for index in (newSelectedIndex + 1)..<itemsServices.count {
                    self.itemsServices[index].update(newState: .next)
                }
            }
        } else if newSelectedIndex < previousSelectedIndex {
            var delay: TimeInterval = 0.0
            
            if previousSelectedIndex < itemsServices.count - 1 {
                for index in (previousSelectedIndex + 1)..<itemsServices.count {
                    self.itemsServices[index].update(newState: .next)
                }
            }
            
            for index in 0..<newSelectedIndex {
                self.itemsServices[index].update(newState: .success)
            }
            
            for index in stride(from: previousSelectedIndex, through: newSelectedIndex + 1, by: -1) {
                Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
                    self.itemsServices[index].update(newState: .next)
                }
                delay += animationDelay
            }
            Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
                self.itemsServices[newSelectedIndex].update(newState: .current)
            }
            delay += animationDelay
            totalAnimationTime = delay
        } else {
            for (index, service) in itemsServices.enumerated() {
                if index < newSelectedIndex {
                    service.update(newState: .success)
                } else if index == newSelectedIndex {
                    service.update(newState: .current)
                } else {
                    service.update(newState: .next)
                }
            }
            totalAnimationTime = 0.0
        }
        
        viewProperties.itemViews = itemsServices.map { $0.view }
        
        Timer.scheduledTimer(withTimeInterval: totalAnimationTime + 0.1, repeats: false) { _ in
            self.previousSelectedIndex = newSelectedIndex
            self.isAnimating = false
            
            if let pendingIndex = self.pendingNewSelectedIndex {
                self.pendingNewSelectedIndex = nil
                self.setupItems(with: pendingIndex)
            }
        }
    }
}
