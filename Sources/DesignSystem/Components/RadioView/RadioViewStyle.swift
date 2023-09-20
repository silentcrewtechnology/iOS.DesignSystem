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

private enum Constant {
    
    enum Small {
        static let radiosize: CGFloat = 16
        static let radioDotOnsize: CGFloat = 8
        static let radioDotOffsize: CGFloat = 14
    }
    
    enum Large {
        static let radiosize: CGFloat = 20
        static let radioDotOnsize: CGFloat = 10
        static let radioDotOffsize: CGFloat = 18
    }
    
    static let radioBackgroundColorOff: UIColor = .borderMain
    static let radioDotBackgroundColorOff: UIColor = .backgroundPrimary
    static let radioBackgroundColorOffDisabled: UIColor = .borderMain
    static let radioDotBackgroundColorOffDisabled: UIColor = .backgroundDisabled
    
    static let radioBackgroundColorOn: UIColor = .backgroundAction
    static let radioDotBackgroundColorOn: UIColor = .contentActionOn
    static let radioBackgroundColorOnDisabled: UIColor = .backgroundActionActiveDisabled
    static let radioDotBackgroundColorOnDisabled: UIColor = .contentActionOn
}
