import UIKit
import Components
import Colors

public struct ChipsViewStyle {
    
    public enum Style {
        case primary
        case secondary
    }
    
    public enum Size {
        case small
        case large
    }
    
    public enum State {
        case `default`
        case pressed(from: Toggle)
        case active
        case disabled
        
        public enum Toggle {
            case inactive
            case active
        }
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
        with viewProperties: inout ChipsView.ViewProperties
    ) {
        viewProperties.insets = size.insets(
            hasLeftView: viewProperties.leftView != nil,
            hasRightView: viewProperties.rightView != nil)
        viewProperties.text = viewProperties.text.fontStyle(size.fontStyle())
    }
    
    public func update(
        state: State,
        viewProperties: inout ChipsView.ViewProperties
    ) {
        viewProperties.backgroundColor = style.backgroundColor(state: state)
        viewProperties.text = viewProperties.text.foregroundColor(tintColor(state: state))
    }
    
    public func tintColor(
        state: State
    ) -> UIColor {
        style.tintColor(state: state)
    }
}

public extension ChipsViewStyle.Size {
    
    func fontStyle() -> FontStyle {
        switch self {
        case .small: .textS
        case .large: .textM
        }
    }
    
    func insets(
        hasLeftView: Bool,
        hasRightView: Bool
    ) -> UIEdgeInsets {
        
        func smallInsets() -> UIEdgeInsets {
            switch (hasLeftView, hasRightView) {
            case (false, false): .init(top: 6, left: 16, bottom: 6, right: 16)
            case (false, true): .init(top: 6, left: 16, bottom: 6, right: 8)
            case (true, false): .init(top: 6, left: 8, bottom: 6, right: 16)
            case (true, true): .init(top: 6, left: 8, bottom: 6, right: 8)
            }
        }
        
        func largeInsets() -> UIEdgeInsets {
            switch (hasLeftView, hasRightView) {
            case (false, false): .init(top: 8, left: 20, bottom: 8, right: 20)
            case (false, true): .init(top: 8, left: 20, bottom: 8, right: 8)
            case (true, false): .init(top: 8, left: 8, bottom: 8, right: 20)
            case (true, true): .init(top: 8, left: 8, bottom: 8, right: 8)
            }
        }
        
        switch self {
        case .small: return smallInsets()
        case .large: return largeInsets()
        }
    }
}

public extension ChipsViewStyle.Style {
    
    func backgroundColor(
        state: ChipsViewStyle.State
    ) -> UIColor {
        
        func primaryBackgroundColor() -> UIColor {
            switch state {
            case .default: .backgroundActionLight
            case .pressed: .backgroundActionLightPressed
            case .active: .backgroundAction
            case .disabled: .backgroundDisabled
            }
        }

        func secondaryBackgroundColor() -> UIColor {
            switch state {
            case .default: .backgroundSecondary
            case .pressed: .backgroundTertiary
            case .active: .backgroundAction
            case .disabled: .backgroundDisabled
            }
        }
        
        switch self {
        case .primary: return primaryBackgroundColor()
        case .secondary: return secondaryBackgroundColor()
        }
    }
    
    func tintColor(
        state: ChipsViewStyle.State
    ) -> UIColor {
        
        func primaryTintColor() -> UIColor {
            switch state {
            case .default: .contentActionDark
            case .pressed: .contentActionDark
            case .active: .contentActionOn
            case .disabled: .contentDisabled
            }
        }

        func secondaryTintColor() -> UIColor {
            switch state {
            case .default: .contentPrimary
            case .pressed: .contentPrimary
            case .active: .contentActionOn
            case .disabled: .contentDisabled
            }
        }
        
        switch self {
        case .primary: return primaryTintColor()
        case .secondary: return secondaryTintColor()
        }
    }
}
