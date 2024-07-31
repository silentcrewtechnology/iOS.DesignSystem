import UIKit
import Components
import Colors

public struct ChipsViewStyle {
    
    public typealias Selection = ChipsVariables.Selection
    public typealias State = ChipsVariables.State
    
    public enum Size {
        case small
        case large
    }
    
    private var variables: ChipsVariables
    public var selection: Selection {
        get { variables.selection }
        set { variables = .init(selection: newValue, state: state) }
    }
    public var state: State {
        get { variables.state }
        set { variables = .init(selection: selection, state: newValue) }
    }
    private let size: Size
    
    public init(
        selection: Selection,
        state: State,
        size: Size
    ) {
        self.variables = .init(selection: selection, state: state)
        self.size = size
    }
    
    public func update(
        viewProperties: inout ChipsView.ViewProperties
    ) {
        viewProperties.height = size.height()
        viewProperties.insets = size.insets(
            hasLeftView: viewProperties.leftView != nil,
            hasRightView: viewProperties.rightView != nil)
        viewProperties.backgroundColor = variables.backgroundColor()
        viewProperties.cornerRadius = viewProperties.height / 2
        viewProperties.text = viewProperties.text
            .fontStyle(size.fontStyle())
            .foregroundColor(variables.labelColor())
        viewProperties.isUserInteractionEnabled = state != .disabled
        tintIcons(viewProperties: &viewProperties)
        resizeIcons(viewProperties: &viewProperties)
    }
    
    private func tintIcons(
        viewProperties: inout ChipsView.ViewProperties
    ) {
        let iconColor = variables.iconColor()
        if let view = viewProperties.leftView as? UIImageView {
            view.image = view.image?.withTintColor(iconColor)
        }
        if let view = viewProperties.rightView as? UIImageView {
            view.image = view.image?.withTintColor(iconColor)
        }
    }
    
    private func resizeIcons(
        viewProperties: inout ChipsView.ViewProperties
    ) {
        if let view = viewProperties.leftView as? UIImageView {
            view.contentMode = .center
            view.snp.remakeConstraints { $0.size.equalTo(32) }
        }
        if let view = viewProperties.rightView as? UIImageView {
            view.contentMode = .center
            view.snp.remakeConstraints { $0.size.equalTo(32) }
        }
    }
}

private extension ChipsViewStyle.Size {
    
    func insets(
        hasLeftView: Bool,
        hasRightView: Bool
    ) -> UIEdgeInsets {
        return .init(
            top: 0,
            left: hasLeftView ? 8 : 16,
            bottom: 0,
            right: hasRightView ? 8 : 16)
    }
    
    func height() -> CGFloat {
        switch self {
        case .small: 32
        case .large: 40
        }
    }
    
    func fontStyle() -> FontStyle {
        switch self {
        case .small: .textS
        case .large: .textM
        }
    }
}

public struct ChipsVariables {
    
    public enum Selection: String {
        case `default`
        case selected
    }
    
    public enum State: String {
        case `default`
        case pressed
        case disabled
    }
    
    public var selection: Selection
    public var state: State
    
    public init(
        selection: Selection,
        state: State
    ) {
        self.selection = selection
        self.state = state
    }
    
    public func backgroundColor() -> UIColor {
        switch selection {
        case .default: backgroundDefaultColor()
        case .selected: backgroundSelectedColor()
        }
    }
    
    public func labelColor() -> UIColor {
        switch selection {
        case .default: labelDefaultColor()
        case .selected: labelSelectedColor()
        }
    }
    
    public func iconColor() -> UIColor {
        switch selection {
        case .default: iconDefaultColor()
        case .selected: iconSelectedColor()
        }
    }
    
    private func backgroundDefaultColor() -> UIColor {
        switch state {
        case .default: .Components.Chips.Default.Background.Color.default
        case .pressed: .Components.Chips.Default.Background.Color.pressed
        case .disabled: .Components.Chips.Default.Background.Color.disabled
        }
    }
    
    private func backgroundSelectedColor() -> UIColor {
        switch state {
        case .default: .Components.Chips.Selected.Background.Color.default
        case .pressed: .Components.Chips.Selected.Background.Color.pressed
        case .disabled: .Components.Chips.Selected.Background.Color.disabled
        }
    }
    
    private func labelDefaultColor() -> UIColor {
        switch state {
        case .default: .Components.Chips.Default.Label.Color.default
        case .pressed: .Components.Chips.Default.Label.Color.pressed
        case .disabled: .Components.Chips.Default.Label.Color.disabled
        }
    }
    
    private func labelSelectedColor() -> UIColor {
        switch state {
        case .default: .Components.Chips.Selected.Label.Color.default
        case .pressed: .Components.Chips.Selected.Label.Color.pressed
        case .disabled: .Components.Chips.Selected.Label.Color.disabled
        }
    }
    
    private func iconDefaultColor() -> UIColor {
        switch state {
        case .default: .Components.Chips.Default.Icon.Color.default
        case .pressed: .Components.Chips.Default.Icon.Color.pressed
        case .disabled: .Components.Chips.Default.Icon.Color.disabled
        }
    }
    
    private func iconSelectedColor() -> UIColor {
        switch state {
        case .default: .Components.Chips.Selected.Icon.Color.default
        case .pressed: .Components.Chips.Selected.Icon.Color.pressed
        case .disabled: .Components.Chips.Selected.Icon.Color.disabled
        }
    }
}
