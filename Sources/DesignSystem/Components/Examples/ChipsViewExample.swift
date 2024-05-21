import UIKit
import SnapKit
import Components
import ImagesService

private class ChipsViewVC: UIViewController {
    
    private var styles: [[ChipsViewStyle]] = [
        (0..<4).map { _ in .init(selection: .default, state: .default, size: .large) },
        (0..<4).map { _ in .init(selection: .default, state: .pressed, size: .large) },
        (0..<4).map { _ in .init(selection: .default, state: .disabled, size: .large) },
        (0..<4).map { _ in .init(selection: .selected, state: .default, size: .small) },
        (0..<4).map { _ in .init(selection: .selected, state: .pressed, size: .small) },
        (0..<4).map { _ in .init(selection: .selected, state: .disabled, size: .small) }
    ]
    
    private var updaters: [ChipsViewUpdater] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vStack = vStack()
        
        for (i, row) in styles.enumerated() {
            let hStack = hStack()
            for j in row.indices {
                let view = ChipsView()
                hStack.addArrangedSubview(view)
                let viewProperties = ChipsView.ViewProperties(
                    leftView: j == 1 || j == 3 ? leftIconView() : nil,
                    text: {
                        if j == 0 {
                            return "\(i) + \(j)".attributed
                        } else if j == 1 {
                            return "\(i)".attributed
                        } else if j == 2 {
                            return "\(j)".attributed
                        } else {
                            return "+".attributed
                        }
                    }(),
                    rightView: j == 2 || j == 3 ? rightIconView() : nil)
                let updater = ChipsViewUpdater(
                    view: view,
                    viewProperties: viewProperties,
                    style: styles[i][j],
                    onActive: { print("active \(i) + \(j)") },
                    onInactive: { print("inactive \(i) + \(j)") }
                )
                updaters.append(updater)
            }
            vStack.addArrangedSubview(hStack)
        }
        
        view.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func leftIconView() -> UIImageView {
        let view = UIImageView(image: .ic16Tick)
        return view
    }
    
    private func rightIconView() -> UIImageView {
        let view = UIImageView(image: .ic16Close)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rightIconTapped)))
        return view
    }
    
    @objc private func rightIconTapped() {
        print("right icon tapped")
    }
    
    private func vStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        return stack
    }
    
    private func hStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }
}

private class ChipsViewUpdater {
    
    private var view: ChipsView
    private var viewProperties: ChipsView.ViewProperties
    private var style: ChipsViewStyle
    private let onActive: () -> Void
    private let onInactive: () -> Void
    
    init(
        view: ChipsView,
        viewProperties: ChipsView.ViewProperties,
        style: ChipsViewStyle,
        onActive: @escaping () -> Void,
        onInactive: @escaping () -> Void
    ) {
        self.view = view
        self.style = style
        self.onActive = onActive
        self.onInactive = onInactive
        self.viewProperties = viewProperties
        updateView()
    }
    
    private func updateView() {
        viewProperties.onPressChange = { [weak self] state in
            guard let self else { return }
            self.handleTap(state: state)
        }
        style.update(viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
    
    enum State {
        case tap(ChipsView.State)
    }
    
    func handle(state: State) {
        switch state {
        case .tap(let state):
            handleTap(state: state)
        }
    }
    
    private func handleTap(
        state: ChipsView.State
    ) {
        switch (style.state, state) {
        case (.default, .pressed):
            style.state = .pressed
        case (.pressed, .unpressed):
            switch style.selection {
            case .default:
                style.selection = .selected
                onActive()
            case .selected:
                style.selection = .default
                onInactive()
            }
            style.state = .default
        case (.pressed, .cancelled):
            style.state = .default
        default: return
        }
        style.update(viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
}
