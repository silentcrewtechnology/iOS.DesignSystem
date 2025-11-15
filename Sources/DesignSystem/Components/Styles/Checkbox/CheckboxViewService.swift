import UIKit
import Components

public final class CheckboxViewService {
    
    // MARK: - Properties
    
    public private(set) var view: CheckboxView
    public private(set) var viewProperties: CheckboxView.ViewProperties
    public private(set) var style: CheckboxViewStyle
    private var isChecked: Bool
    
    // MARK: - Init
    
    public init(
        view: CheckboxView = .init(),
        viewProperties: CheckboxView.ViewProperties = .init(),
        style: CheckboxViewStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        self.isChecked = style.selection == .on
        
        configurePressChange()
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newSelection: CheckboxVariables.Selection? = nil,
        newState: CheckboxVariables.State? = nil,
        newOnPressChange: ((PressableView.State) -> Void)? = nil,
        newOnTap: ((Bool) -> Void)? = nil
    ) {
        if let newOnPressChange {
            viewProperties.onPressChange = newOnPressChange
            configurePressChange()
        }
        
        if let newOnTap {
            viewProperties.onTap = newOnTap
        }
        
        style.update(
            newSelection: newSelection,
            newState: newState,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
    
    // MARK: - Private methods
    
    private func configurePressChange() {
        viewProperties.onPressChange = { [weak self] state in
            guard let self else { return }
            switch state {
            case .pressed:
                update(newState: .pressed)
            case .unpressed:
                isChecked = !isChecked
                update(newSelection: isChecked ? .on : .off, newState: .default)
                viewProperties.onTap?(isChecked ? true : false)
            case .cancelled: break
            }
        }
    }
}
