import UIKit
import Components
import AccessibilityIds

public final class KeyboardPinViewService {
    
    public typealias V = KeyboardPinView
    
    public private(set) var view: V
    public private(set) var viewProperties: V.ViewProperties
    public private(set) lazy var digitServices: [KeyPinViewService] = "1234567890".enumerated().map { index, digit in
        let digitString = "\(digit)"
        return .init(
            viewProperties: .init(
                digit: digitString.attributed,
                accessibilityId: "\(DesignSystemAccessibilityIDs.KeyPinView.id)\(digitString)"
            ),
            onTap: { [weak self] in
                guard let self else { return }
                onDigitTap(digitString)
            }
        )
    }
    public private(set) var onDigitTap: (String) -> Void
    
    public init(
        view: V = .init(),
        viewProperties: V.ViewProperties = .init(),
        onDigitTap: @escaping (String) -> Void = { _ in }
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.onDigitTap = onDigitTap
        setupKeyPins()
        update()
    }
    
    private func setupKeyPins() {
        viewProperties.keys = digitServices.map(\.view)
    }
    
    public func update() {
        view.update(with: viewProperties)
    }
}
