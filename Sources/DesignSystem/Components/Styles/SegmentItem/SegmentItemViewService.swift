import UIKit
import Components

public final class SegmentItemViewService {
    public private(set) var view: SegmentItemView
    public private(set) var viewProperties: SegmentItemView.ViewProperties
    public private(set) var style: SegmentItemViewStyle
    public private(set) var isSelected: Bool
    
    public init(view: SegmentItemView = .init(),
                viewProperties: SegmentItemView.ViewProperties = .init(),
                size: SegmentItemViewStyle.Size = .sizeS,
                selected: SegmentItemViewStyle.Selected = .false,
                showDivider: SegmentItemViewStyle.ShowDivider = .true) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = SegmentItemViewStyle(
            size: size,
            state: .default,
            selected: selected,
            showDivider: showDivider)
        
        switch selected {
        case .true:
            isSelected = true
        case .false:
            isSelected = false
        }
        
        configureAction()
        update(size: size,
               selected: selected,
               showDivider: showDivider)
    }
    
    private func configureAction() {
        viewProperties.handleTap = { [weak self] state in
            guard let self else { return }
            switch state {
            case .pressed:
                update(state: .pressed)
            case .unpressed:
                isSelected = !isSelected
                let selected: SegmentItemViewStyle.Selected = isSelected ? .true : .false
                
                update(state: .default,
                       selected: selected)
                viewProperties.onItemTap(isSelected)
                
            case .cancelled:
                let selected: SegmentItemViewStyle.Selected = isSelected ? .true : .false
                update(state: .default,
                       selected: selected)
                viewProperties.onItemTap(isSelected)
                break
            }
        }
    }
    
    public func update(
        size: SegmentItemViewStyle.Size? = nil,
        state: SegmentItemViewStyle.State? = nil,
        selected: SegmentItemViewStyle.Selected? = nil,
        showDivider: SegmentItemViewStyle.ShowDivider? = nil
    ) {
        if let selected {
            self.isSelected = selected == .true ? true : false
        }
        
        style.update(size: size,
                     state: state,
                     selected: selected,
                     showDivider: showDivider,
                     viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
}
