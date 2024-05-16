import UIKit
import Components
import Colors
import ImagesService

public struct CheckboxViewStyle {
    
    public enum Size {
        case sizeS
        case sizeL
    }
    
    public enum Action {
        case on
        case off
    }
    
    public enum State {
        case `default`
        case disabled
    }
    
    public var size: Size
    public var state: State
    public var action: Action
    
    public init(
        size: Size,
        state: State,
        action: Action
    ) {
        self.size = size
        self.state = state
        self.action = action
    }
    
    public func update(
        viewProperties: inout CheckboxView.ViewProperties
    ) {
        viewProperties.background.size = size.backgroundSize()
        viewProperties.background.cornerRadius = 4
        viewProperties.indicator.size = size.indicatorSize()
        viewProperties.indicator.image = action.icon()
        viewProperties.indicator.cornerRadius = 3
        switch (state, action) {
        case (.default, .on):
            viewProperties.background.color = .backgroundAction
            viewProperties.indicator.backgroundColor = .clear
        case (.default, .off):
            viewProperties.background.color = .borderMain
            viewProperties.indicator.backgroundColor = .backgroundPrimary
        case (.disabled, .on):
            viewProperties.background.color = .backgroundActionActiveDisabled
            viewProperties.indicator.backgroundColor = .clear
        case (.disabled, .off):
            viewProperties.background.color = .borderDisabled
            viewProperties.indicator.backgroundColor = .backgroundDisabled
        }
    }
}

public extension CheckboxViewStyle.Size {
    
    func backgroundSize() -> CGFloat {
        switch self {
        case .sizeS: 16
        case .sizeL: 20
        }
    }
    
    func indicatorSize() -> CGFloat {
        switch self {
        case .sizeS: 14
        case .sizeL: 18
        }
    }
}

public extension CheckboxViewStyle.Action {
    
    func icon() -> UIImage? {
        switch self {
        case .on: .ic10Check.withTintColor(.contentActionOn)
        case .off: nil
        }
    }
}
