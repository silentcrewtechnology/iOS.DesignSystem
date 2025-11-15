import UIKit
import Components

public final class ChipsViewService {
    
    // MARK: - Properties
    
    public private(set) var view: ChipsView
    public private(set) var viewProperties: ChipsView.ViewProperties
    public private(set) var style: ChipsViewStyle
    private var isSelected: Bool
    
    // MARK: - Init
    
    public init(
        view: ChipsView = .init(),
        viewProperties: ChipsView.ViewProperties = .init(),
        style: ChipsViewStyle = .init()
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        self.isSelected = style.selected == .on
        
        configureHandleTap()
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        set: ChipsViewStyle.Set? = nil,
        size: ChipsViewStyle.Size? = nil,
        state: ChipsViewStyle.State? = nil,
        selected: ChipsViewStyle.Selected? = nil,
        label: ChipsViewStyle.Label? = nil,
        newText: NSMutableAttributedString? = nil,
        newRightImage: UIImage? = nil,
        newLeftImage: UIImage? = nil
    ) {
        if let newText {
            viewProperties.text = newText
        }
        
        if let newRightImage {
            viewProperties.rightImage = newRightImage
        }
        
        if let newLeftImage {
            viewProperties.leftImage = newLeftImage
        }
        
        style.update(
            set: set,
            size: size,
            state: state,
            selected: selected,
            label: label,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
    
    // MARK: - Private methods
    
    private func configureHandleTap() {
        viewProperties.handleTap = { [weak self] state in
            guard let self else { return }
            switch state {
            case .pressed:
                update(state: .pressed)
            case .unpressed:
                isSelected = !isSelected
                let selected: ChipsViewStyle.Selected = isSelected ? .on : . off
                update(state: .default, selected: selected)
                viewProperties.onChipsTap(isSelected)
            case .cancelled: break
            }
        }
    }
}
