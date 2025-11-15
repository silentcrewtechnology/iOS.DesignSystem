import UIKit
import Components

public final class KeyPinBottomRightViewService {
    
    public typealias V = KeyPinBottomRightView
    
    public private(set) var view: V
    public private(set) var viewProperties: V.ViewProperties
    public private(set) var style: KeyPinBottomRightViewStyle
    private var onTap: () -> Void
    
    public init(
        view: V = .init(),
        viewProperties: V.ViewProperties = .init(),
        style: KeyPinBottomRightViewStyle = .init(),
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
        option: KeyPinBottomRightViewStyle.Option? = nil,
        state: KeyPinBottomRightViewStyle.State? = nil
    ) {
        style.update(
            option: option,
            state: state,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
}
