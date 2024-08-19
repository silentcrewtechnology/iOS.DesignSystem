import UIKit
import Components
import Colors

public class ChipsViewStyle {
    
    public enum Set {
        case rightIcon
        case leftIcon
    }
    
    public enum Size {
        case large
        case small
    }
    
    public enum State {
        case `default`
        case pressed
        case disbled
    }
    
    public enum Selected {
        case on
        case off
    }
    
    public enum Label {
        case `true`
        case `false`
    }
    
    public enum Icon {
        case `true`
        case `false`
    }
    
    private var set: Set
    private var size: Size
    private var state: State
    private var selected: Selected
    private var label: Label
    private var icon: Icon
    
    public init(
        set: Set = .leftIcon,
        size: Size = .large,
        state: State = .default,
        selected: Selected = .off,
        label: Label = .true,
        icon: Icon = .true
    ) {
        self.set = set
        self.size = size
        self.state = state
        self.selected = selected
        self.label = label
        self.icon = icon
    }
    
    public func update(
        set: Set? = nil,
        size: Size? = nil,
        state: State? = nil,
        selected: Selected? = nil,
        label: Label? = nil,
        icon: Icon? = nil,
        viewProperties: inout ChipsView.ViewProperties
    ) {
        if let set {
            self.set = set
        }
        if let size {
            self.size = size
        }
        if let state {
            self.state = state
        }
        if let selected {
            self.selected = selected
        }
        if let label {
            self.label = label
        }
        if let icon {
            self.icon = icon
        }
        viewProperties.backgroundColor = backgroundColor(state: self.state, selected: self.selected)
        
        viewProperties.cornerRadius = self.size.cornerRadius()
        viewProperties.leftImageColor = tintColor(state: self.state,
                                                selected: self.selected)
        viewProperties.text = viewProperties.text.string.fontStyle(self.size.fontStyle())
        viewProperties.textColor = tintColor(state: self.state,
                                             selected: self.selected)
        viewProperties.rightImageColor = tintColor(state: self.state,
                                                  selected: self.selected)
        
        switch self.state {
        case .default:
            viewProperties.isUserInteractionEnabled = true
        case .disbled:
            viewProperties.isUserInteractionEnabled = false
        case .pressed:
            viewProperties.isUserInteractionEnabled = true
        }
        viewProperties.margins = getMargins()
    }
    
    private func getMargins() -> ChipsView.ViewProperties.Margins {
        return .init(
            spacing: size.spacing(),
            top: size.top(),
            leading: size.leading(),
            trailing: size.trailing(),
            bottom: size.bottom(),
            height: size.height())
    }
}

extension ChipsViewStyle {
    private func backgroundColor(
        state: State,
        selected: Selected
    ) -> UIColor {
        switch selected {
        case .on: backgroundSelectedOnStyleColor(state: state)
        case .off: backgroundSelectedOffStyleColor(state: state)
        }
    }
    
    private func backgroundSelectedOnStyleColor(
        state: State
    ) -> UIColor {
        switch state {
        case .default: .Components.Chips.Selected.Background.Color.default
        case .disbled: .Components.Chips.Selected.Background.Color.disabled
        case .pressed: .Components.Chips.Selected.Background.Color.pressed
        }
    }
    
    private func backgroundSelectedOffStyleColor(
        state: State
    ) -> UIColor {
        switch state {
        case .default: .Components.Chips.Default.Background.Color.default
        case .disbled: .Components.Chips.Default.Background.Color.disabled
        case .pressed: .Components.Chips.Default.Background.Color.pressed
        }
    }
}

extension ChipsViewStyle {
    private func tintColor(
        state: State,
        selected: Selected
    ) -> UIColor {
        switch selected {
        case .on: tintSelectedOnStyleColor(state: state)
        case .off: tintSelectedOffStyleColor(state: state)
        }
    }
    
    private func tintSelectedOnStyleColor(
        state: State
    ) -> UIColor {
        switch state {
        case .default: .Components.Chips.Selected.Label.Color.default
        case .disbled: .Components.Chips.Selected.Label.Color.disabled
        case .pressed: .Components.Chips.Selected.Label.Color.pressed
        }
    }
    
    private func tintSelectedOffStyleColor(
        state: State
    ) -> UIColor {
        switch state {
        case .default: .Components.Chips.Default.Label.Color.default
        case .disbled: .Components.Chips.Default.Label.Color.disabled
        case .pressed: .Components.Chips.Default.Label.Color.pressed
        }
    }
}
    
extension ChipsViewStyle.Size {
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
    
    func cornerRadius() -> CGFloat {
        return self.height() / 2
    }
    
    func spacing() -> CGFloat {
        switch self {
        case .small: 8
        case .large: 8
        }
    }
    
    func top() -> CGFloat {
        switch self {
        case .small: 6
        case .large: 8
        }
    }
    
    func leading() -> CGFloat {
        switch self {
        case .small: 16
        case .large: 16
        }
    }
    
    func trailing() -> CGFloat {
        switch self {
        case .small: 16
        case .large: 16
        }
    }
    
    func bottom() -> CGFloat {
        switch self {
        case .small: 6
        case .large: 8
        }
    }
}
