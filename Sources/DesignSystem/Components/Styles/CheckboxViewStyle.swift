import UIKit
import Colors

public enum CheckboxViewStyle {
    
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
        viewProperties: CheckboxView.ViewProperties
    ) -> CheckboxView.ViewProperties {
        var viewProperties = viewProperties
        switch size {
        case .small:
            viewProperties.background.size = 16
            viewProperties.indicator.size = 14
        case .large:
            viewProperties.background.size = 20
            viewProperties.indicator.size = 18
        }
        viewProperties.background.cornerRadius = 4
        viewProperties.indicator.cornerRadius = 3
        return viewProperties
    }
    
    public static func update(
        state: State,
        action: Action,
        viewProperties: CheckboxView.ViewProperties
    ) -> CheckboxView.ViewProperties {
        var viewProperties = viewProperties
        switch (state, action) {
        case (.default, .on):
            viewProperties.background.color = .backgroundAction
            viewProperties.indicator.image = .ic10Check.tinted(with: .contentActionOn)
            viewProperties.indicator.backgroundColor = .clear
        case (.default, .off):
            viewProperties.background.color = .borderMain
            viewProperties.indicator.image = nil
            viewProperties.indicator.backgroundColor = .backgroundPrimary
        case (.disabled, .on):
            viewProperties.background.color = .backgroundActionActiveDisabled
            viewProperties.indicator.image = .ic10Check.tinted(with: .contentActionOn)
            viewProperties.indicator.backgroundColor = .clear
        case (.disabled, .off):
            viewProperties.background.color = .borderDisabled
            viewProperties.indicator.image = nil
            viewProperties.indicator.backgroundColor = .backgroundDisabled
        }
        return viewProperties
    }
}
