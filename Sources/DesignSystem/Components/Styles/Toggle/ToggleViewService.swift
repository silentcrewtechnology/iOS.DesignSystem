import UIKit
import Components

public final class ToggleViewService {
    
    // MARK: - Properties
    
    public private(set) var view: ToggleView
    public private(set) var viewProperties: ToggleView.ViewProperties
    public private(set) var style: ToggleViewStyle
    
    // MARK: - Init
    
    public init(
        view: ToggleView = .init(),
        viewProperties: ToggleView.ViewProperties = .init(),
        style: ToggleViewStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        
        configureHandlePress()
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newState: ToggleViewStyle.State? = nil,
        newChecked: ToggleViewStyle.Checked? = nil
    ) {
        style.update(
            newState: newState,
            newChecked: newChecked,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
    
    // MARK: - Private properties
    
    private func configureHandlePress() {
        viewProperties.handlePress = { [weak self] isOn in
            self?.update(newChecked: isOn ? .on : .off)
            self?.viewProperties.checkAction(isOn)
        }
    }
}
