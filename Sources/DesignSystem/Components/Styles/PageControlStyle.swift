import Components
import UIKit

public struct PageControlStyle {

    public enum Size {
        case big
        case normal
        case small
    }

    private let size: Size

    public init(
        size: Size
    ) {
        self.size = size
    }

    public func update(
        viewProperties: inout PageControl.ViewProperties
    ) {
        viewProperties.dotView = .init(
            dotSize: dotSize(),
            selectedBackgroundColor: .backgroundTertiaryPressed,
            notSelectedBackgroundColor: .backgroundTertiary
        )
    }
}


public extension PageControlStyle {
    func dotSize() -> CGSize {
        switch size {
        case .big:
            return CGSize(width: 8, height: 8)
        case .normal:
            return CGSize(width: 6, height: 6)
        case .small:
            return CGSize(width: 4, height: 4)
        }
    }
}
