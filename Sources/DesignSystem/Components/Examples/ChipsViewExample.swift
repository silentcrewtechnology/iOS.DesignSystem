import UIKit
import SnapKit
import Components

private class Example {
    
    let view = ChipsView()
    var updater: ChipsViewLeftIconRightBadgeUpdater?
    let badgeView = BadgeView()
    
    func example() {
        let badgeViewProperties = BadgeStyle.action.apply(
            with: .init(text: "99+".attributed))
        badgeView.update(with: badgeViewProperties)
        let updater = ChipsViewLeftIconRightBadgeUpdater(
            view: view,
            leftView: iconImageView(icon: .ic24Car, size: 24),
            text: "Label".attributed,
            rightView: badgeView,
            style: .init(style: .primary, size: .large),
            state: .default,
            onActive: { print("active") },
            onInactive: { print("inactive") }
        )
        self.updater = updater
    }
    
    func iconImageView(
        icon: UIImage,
        size: CGFloat
    ) -> UIView {
        let view = UIImageView(image: icon)
        view.snp.makeConstraints { $0.size.equalTo(size) }
        return view
    }
}

private class ChipsViewLeftIconRightBadgeUpdater {
    
    private weak var view: ChipsView?
    private var viewProperties: ChipsView.ViewProperties
    private let style: ChipsViewStyle
    private var state: ChipsViewStyle.State {
        didSet { updateState(state: state) }
    }
    private let onActive: () -> Void
    private let onInactive: () -> Void
    
    public init(
        view: ChipsView? = nil,
        leftView: UIView? = nil,
        text: NSMutableAttributedString = "".attributed,
        rightView: UIView? = nil,
        style: ChipsViewStyle,
        state: ChipsViewStyle.State = .default,
        onActive: @escaping () -> Void = { },
        onInactive: @escaping () -> Void = { }
    ) {
        self.view = view
        self.style = style
        self.state = state
        self.onActive = onActive
        self.onInactive = onInactive
        self.viewProperties = .init(
            leftView: leftView,
            text: text,
            rightView: rightView)
        updateView()
    }
    
    private func updateView() {
        viewProperties.onPressChange = { [weak self] tapState in
            guard let self else { return }
            self.updateTapState(tapState: tapState)
        }
        style.update(with: &viewProperties)
        tintLeftIcon()
        style.update(state: state, viewProperties: &viewProperties)
        view?.update(with: viewProperties)
    }
    
    private func tintLeftIcon() {
        let leftView = viewProperties.leftView as? UIImageView
        leftView?.image = leftView?.image?.tinted(with: style.tintColor(state: state))
    }
    
    private func updateState(state: ChipsViewStyle.State) {
        tintLeftIcon()
    }
    
    private func updateTapState(
        tapState: ChipsView.State
    ) {
        switch (state, tapState) {
        case (.default, .pressed):
            state = .pressed(from: .inactive)
        case (.active, .pressed):
            state = .pressed(from: .active)
        case (.pressed(let from), .unpressed):
            switch from {
            case .inactive:
                state = .active
                // состояние меняется до вызова замыкания
                onActive()
            case .active:
                state = .default
                // состояние меняется до вызова замыкания
                onInactive()
            }
        case (.pressed(let from), .cancelled):
            switch from {
            case .inactive: state = .default
            case .active: state = .active
            }
        default: return
        }
        style.update(state: state, viewProperties: &viewProperties)
        view?.update(with: viewProperties)
    }
}
