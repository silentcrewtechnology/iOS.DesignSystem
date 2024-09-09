import UIKit
import Components

public final class InputPinViewService {
    
    public typealias V = InputPinView
    
    public private(set) var view: V
    public private(set) var viewProperties: V.ViewProperties
    public private(set) var style: InputPinViewStyle
    public private(set) var itemServices: [InputPinItemViewService]
    
    public init(
        view: V = .init(),
        viewProperties: V.ViewProperties = .init(),
        style: InputPinViewStyle = .init(),
        itemServices: [InputPinItemViewService] = []
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        self.itemServices = itemServices
        setupItems()
        update()
    }
    
    private func setupItems() {
        viewProperties.items = itemServices.map(\.view)
    }
    
    private func update() {
        style.update(viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
    
    public func update(
        state: InputPinItemViewStyle.State,
        range: Range<Int>
    ) {
        for (i, itemService) in itemServices.enumerated() {
            if range ~= i {
                itemService.update(state: state)
            } else {
                itemService.update(state: .default)
            }
        }
    }
}
