import UIKit
import Components
import Colors

public final class ChipsViewStyle {
    
    // MARK: - Properties
    
    public enum Set {
        case rightIcon
        case leftIcon
        case none
    }
    
    public enum Size {
        case large
        case small
    }
    
    public enum State {
        case `default`
        case pressed
        case disabled
    }
    
    public enum Selected {
        case on
        case off
    }
    
    public enum Label {
        case `true`
        case `false`
    }
    
    public private(set) var selected: Selected
    
    // MARK: - Private properties
    
    private var set: Set
    private var size: Size
    private var state: State
    private var label: Label
    
    // MARK: - Init
    
    public init(
        set: Set = .leftIcon,
        size: Size = .large,
        state: State = .default,
        selected: Selected = .off,
        label: Label = .true
    ) {
        self.set = set
        self.size = size
        self.state = state
        self.selected = selected
        self.label = label
    }
    
    // MARK: - Methods
    
    public func update(
        set: Set? = nil,
        size: Size? = nil,
        state: State? = nil,
        selected: Selected? = nil,
        label: Label? = nil,
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
        
        let tintColor = tintColor(
            state: self.state,
            selected: self.selected
        )
        viewProperties.backgroundColor = backgroundColor(state: self.state, selected: self.selected)
        viewProperties.cornerRadius = self.size.cornerRadius()
        viewProperties.margins = getMargins()
        viewProperties.isUserInteractionEnabled = state != .disabled
        viewProperties.isLeftImageHidden = self.set.isLeftIconHidden()
        viewProperties.isRightImageHidden = self.set.isRightIconHidden()
        viewProperties.isTextHidden = self.label == .false
        viewProperties.text = viewProperties.text
            .fontStyle(self.size.fontStyle())
            .foregroundColor(tintColor)
        viewProperties.leftImage = viewProperties.leftImage?
            .withTintColor(tintColor)
        viewProperties.rightImage = viewProperties.rightImage?
            .withTintColor(tintColor)
    }
    
    // MARK: - Private methods
    
    private func getMargins() -> ChipsView.ViewProperties.Margins {
        return .init(
            insets: size.insets(),
            spacing: size.spacing(),
            height: size.height())
    }
}

// MARK: - ChipsViewStyle Extension

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
        case .disabled: .Components.Chips.Selected.Background.Color.disabled
        case .pressed: .Components.Chips.Selected.Background.Color.pressed
        }
    }
    
    private func backgroundSelectedOffStyleColor(
        state: State
    ) -> UIColor {
        switch state {
        case .default: .Components.Chips.Default.Background.Color.default
        case .disabled: .Components.Chips.Default.Background.Color.disabled
        case .pressed: .Components.Chips.Default.Background.Color.pressed
        }
    }
}

// MARK: - ChipsViewStyle Extension

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
        case .disabled: .Components.Chips.Selected.Label.Color.disabled
        case .pressed: .Components.Chips.Selected.Label.Color.pressed
        }
    }
    
    private func tintSelectedOffStyleColor(
        state: State
    ) -> UIColor {
        switch state {
        case .default: .Components.Chips.Default.Label.Color.default
        case .disabled: .Components.Chips.Default.Label.Color.disabled
        case .pressed: .Components.Chips.Default.Label.Color.pressed
        }
    }
}

// MARK: - ChipsViewStyle.Set Extension

public extension ChipsViewStyle.Set {
    
    func isLeftIconHidden() -> Bool {
        switch self {
        case .rightIcon, .none: true
        case .leftIcon: false
        }
    }
    
    func isRightIconHidden() -> Bool {
        switch self {
        case .rightIcon: false
        case .leftIcon, .none: true
        }
    }
}

// MARK: - ChipsViewStyle.Size Extension
    
public extension ChipsViewStyle.Size {
    
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
        case .small, .large: 8
        }
    }
    
    func insets() -> UIEdgeInsets {
        switch self {
        case .large: .init(top: 8, left: 16, bottom: 8, right: 16)
        case .small: .init(top: 6, left: 16, bottom: 6, right: 16)
        }
    }
}
