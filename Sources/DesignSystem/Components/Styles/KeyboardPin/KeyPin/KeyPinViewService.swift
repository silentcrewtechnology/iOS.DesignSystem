import UIKit
import Components

public final class KeyPinViewService {
    
    public private(set) var view: KeyPinView
    public private(set) var viewProperties: KeyPinView.ViewProperties
    public private(set) var style: KeyPinViewStyle
    private var onTap: () -> Void
    
    public init(
        view: KeyPinView = .init(),
        viewProperties: KeyPinView.ViewProperties = .init(),
        style: KeyPinViewStyle = .init(),
        onTap: @escaping () -> Void = { }
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        self.onTap = onTap
        configureAction()
        update()
    }
    
    private func configureAction() {
        viewProperties.onPressChange = { [weak self] state in
            guard let self else { return }
            switch state {
            case .pressed:
                update(state: .pressed)
            case .unpressed:
                onTap()
                update(state: .default)
            case .cancelled:
                update(state: .default)
            }
        }
    }
    
    public func update(
        state: KeyPinViewStyle.State? = nil
    ) {
        style.update(
            state: state,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
}
