import UIKit
import Components

public final class RadioViewService {
    
    // MARK: - Properties
    
    public private(set) var view: RadioView
    public private(set) var viewProperties: RadioView.ViewProperties
    public private(set) var style: RadioViewStyle
    private var isChecked: Bool
    
    // MARK: - Init
    
    public init(
        view: RadioView = .init(),
        viewProperties: RadioView.ViewProperties = .init(),
        style: RadioViewStyle
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
        newSelection: RadioViewStyle.Selection? = nil,
        newState: RadioViewStyle.State? = nil,
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
            state: newState,
            selection: newSelection,
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
