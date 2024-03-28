import UIKit
import Components
import Colors

public struct IndicatorViewStyle {
    
    public enum Style {
        case danger
        case success
        case warning
        case info
        case disable
    }
    
    public enum Size {
        case sizeS
        case sizeM
        case sizeL
    }
    
    private let style: Style
    private let size: Size
    
    public init(
        style: Style,
        size: Size
    ) {
        self.style = style
        self.size = size
    }
    
    public func update(
        viewProperties: inout IndicatorView.ViewProperties
    ) {
        viewProperties.size = size.size()
        viewProperties.backgroundColor = style.backgroundColor()
    }
}

public extension IndicatorViewStyle.Style {
    
    func backgroundColor() -> UIColor {
        switch self {
        case .danger: .contentError
        case .success: .backgroundSuccess
        case .warning: .contentWarning
        case .info: .contentInfo
        case .disable: .contentDisabled
        }
    }
}

public extension IndicatorViewStyle.Size {
    
    func size() -> CGFloat {
        switch self {
        case .sizeS: 8
        case .sizeM: 10
        case .sizeL: 12
        }
    }
}
