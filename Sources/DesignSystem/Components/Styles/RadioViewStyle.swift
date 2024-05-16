import UIKit
import Components

public struct RadioViewStyle {
    
    public enum Size {
        case small
        case large
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
    public var action: Action
    public var state: State
    
    public init(
        size: Size,
        action: Action,
        state: State
    ) {
        self.size = size
        self.action = action
        self.state = state
    }
    
    public func update(
        viewProperties: inout RadioView.ViewProperties
    ) {
        switch size {
        case .small:
            viewProperties.background.size = 16
            viewProperties.offIndicator.size = 14
            viewProperties.onIndicator.size = 8
        case .large:
            viewProperties.background.size = 20
            viewProperties.offIndicator.size = 18
            viewProperties.onIndicator.size = 10
        }
        
        switch (state, action) {
        case (.default, .on):
            viewProperties.background.color = .backgroundAction
            viewProperties.onIndicator.color = .contentActionOn
            viewProperties.offIndicator.color = .clear
        case (.default, .off):
            viewProperties.background.color = .borderMain
            viewProperties.onIndicator.color = .clear
            viewProperties.offIndicator.color = .backgroundPrimary
        case (.disabled, .on):
            viewProperties.background.color = .backgroundActionActiveDisabled
            viewProperties.onIndicator.color = .contentActionOn
            viewProperties.offIndicator.color = .clear
        case (.disabled, .off):
            viewProperties.background.color = .borderDisabled
            viewProperties.onIndicator.color = .clear
            viewProperties.offIndicator.color = .backgroundDisabled
        }
    }
}
