import UIKit
import Components

public final class ChipsViewService {
    public private(set) var view: ChipsView
    public private(set) var viewProperties: ChipsView.ViewProperties
    public private(set) var style: ChipsViewStyle
    public private(set) var isSelected: Bool
    
    public init(view: ChipsView = .init(),
                viewProperties: ChipsView.ViewProperties = .init(),
                style: ChipsViewStyle = .init(),
                isSelected: Bool = false) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        self.isSelected = isSelected
        
        configureAction()
        update()
    }
    
    private func configureAction() {
        viewProperties.handleTap = { [weak self] state in
            guard let self else { return }
            switch state {
            case .pressed:
                update(state: .pressed)
            case .unpressed:
                isSelected = !isSelected
                let selected: ChipsViewStyle.Selected = isSelected ? .on : . off
                
                update(state: .default,
                       selected: selected)
                viewProperties.onChipsTap(isSelected)
                
            case .cancelled:
                let selected: ChipsViewStyle.Selected = isSelected ? .on : . off
                update(state: .default,
                       selected: selected)
                viewProperties.onChipsTap(isSelected)
                break
            }
        }
    }
    
    public func update(
        set: ChipsViewStyle.Set? = nil,
        size: ChipsViewStyle.Size? = nil,
        state: ChipsViewStyle.State? = nil,
        selected: ChipsViewStyle.Selected? = nil,
        label: ChipsViewStyle.Label? = nil,
        icon: ChipsViewStyle.Icon? = nil
    ) {
        style.update(set: set,
                     size: size,
                     state: state,
                     selected: selected,
                     label: label,
                     icon: icon,
                     viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
}
