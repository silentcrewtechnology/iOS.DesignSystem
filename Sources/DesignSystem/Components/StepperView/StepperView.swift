import UIKit
import SnapKit

public final class StepperView: UIView {
    
    public struct ViewProperties {
        public var items: [StepperItemView.ViewProperties]
        public var height: CGFloat
        
        public init(
            items: [StepperItemView.ViewProperties] = [],
            height: CGFloat = 0
        ) {
            self.items = items
            self.height = height
        }
    }
    
    private var viewProperties: ViewProperties = .init()
    
    private let itemsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        stack.distribution = .fillEqually
        return stack
    }()
    
    private func setupItemsStack() {
        addSubview(itemsStack)
        itemsStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(viewProperties.height)
        }
    }
    
    public func create(with viewProperties: ViewProperties) {
        self.viewProperties = viewProperties
        setupItemsStack()
        for _ in 0..<viewProperties.items.count {
            let itemView = StepperItemView()
            itemView.create(with: .init())
            itemsStack.addArrangedSubview(itemView)
        }
    }
    
    public func update(with viewProperties: ViewProperties) {
        let itemViews = itemsStack.arrangedSubviews.compactMap { $0 as? StepperItemView }
        for (itemView, itemViewProperties) in zip(itemViews, viewProperties.items) {
            itemView.update(with: itemViewProperties)
        }
        self.viewProperties = viewProperties
    }
}
