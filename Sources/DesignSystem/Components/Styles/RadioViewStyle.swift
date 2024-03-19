import UIKit

public enum RadioViewStyle {
    
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
    
    public static func update(
        size: Size,
        viewProperties: RadioView.ViewProperties
    ) -> RadioView.ViewProperties {
        var viewProperties = viewProperties
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
        return viewProperties
    }
    
    public static func update(
        state: State,
        action: Action,
        viewProperties: RadioView.ViewProperties
    ) -> RadioView.ViewProperties {
        var viewProperties = viewProperties
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
        return viewProperties
    }
}
