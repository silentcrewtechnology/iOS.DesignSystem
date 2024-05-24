import UIKit
import SnapKit
import Components

private class ExampleVC: UIViewController {
    
    private var styles: [[CheckboxViewStyle]] = [
        (0..<4).map { _ in .init(selection: .default, state: .default) },
        (0..<4).map { _ in .init(selection: .default, state: .pressed) },
        (0..<4).map { _ in .init(selection: .default, state: .disabled) },
        (0..<4).map { _ in .init(selection: .checked, state: .default) },
        (0..<4).map { _ in .init(selection: .checked, state: .pressed) },
        (0..<4).map { _ in .init(selection: .checked, state: .disabled) }
    ]
    
    private var updaters: [CheckboxViewUpdater] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vStack = vStack()
        
        for (i, row) in styles.enumerated() {
            let hStack = hStack()
            for j in row.indices {
                let view = CheckboxView()
                hStack.addArrangedSubview(view)
                let updater = CheckboxViewUpdater(
                    view: view,
                    viewProperties: .init(),
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

private class CheckboxViewUpdater {
    
    private var view: CheckboxView
    private var viewProperties: CheckboxView.ViewProperties
    private var style: CheckboxViewStyle
    private let onActive: () -> Void
    private let onInactive: () -> Void
    
    init(
        view: CheckboxView,
        viewProperties: CheckboxView.ViewProperties,
        style: CheckboxViewStyle,
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
            self.handle(state: .tap(state))
        }
        style.update(viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
    
    enum State {
        case tap(CheckboxView.State)
    }
    
    func handle(state: State) {
        switch state {
        case .tap(let state):
            handleTap(state: state)
        }
    }
    
    private func handleTap(
        state: CheckboxView.State
    ) {
        switch (style.state, state) {
        case (.default, .pressed):
            style.state = .pressed
        case (.pressed, .unpressed):
            switch style.selection {
            case .default:
                style.selection = .checked
                onActive()
            case .checked:
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
