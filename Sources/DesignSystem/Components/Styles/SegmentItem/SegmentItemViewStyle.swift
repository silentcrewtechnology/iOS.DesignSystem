import UIKit
import Colors
import Components

public final class SegmentItemViewStyle {
    
    // MARK: - Properties
    
    private typealias ViewProperties = SegmentItemView.ViewProperties
    
    public enum Size {
        case sizeS
        case sizeL
    }
    
    public enum State {
        case `default`
        case pressed
    }
    
    public enum Selected {
        case `true`
        case `false`
    }
    
    public enum ShowDivider {
        case `true`
        case `false`
    }
    
    // MARK: - Private properties
    
    private var size: Size
    private var state: State
    private var selected: Selected
    private var showDivider: ShowDivider
    
    // MARK: - Init
    
    public init(
        size: Size = .sizeS,
        state: State = .default,
        selected: Selected = .false,
        showDivider: ShowDivider = .false
    ) {
        self.size = size
        self.state = state
        self.selected = selected
        self.showDivider = showDivider
    }
    
    // MARK: - Methods
    
    public func update(
        size: Size? = nil,
        state: State? = nil,
        selected: Selected? = nil,
        showDivider: ShowDivider? = nil,
        viewProperties: inout SegmentItemView.ViewProperties
    ) {
        if let size {
            self.size = size
        }
        
        if let state {
            self.state = state
        }
        
        if let selected {
            self.selected = selected
        }
        
        if let showDivider {
            self.showDivider = showDivider
        }
        
        viewProperties.text = viewProperties.text
            .fontStyle(self.size.fontStyle())
            .alignment(.center)
            .foregroundColor(tintColor())
        viewProperties.isDividerHidden = self.showDivider.isDividerHidden()
        viewProperties.margins = getMargins()
        viewProperties.cornerRadius = self.size.cornerRadius()
        viewProperties.backgroundColor = backgroundColor()
    }
    
    // MARK: - Private methods
    
    private func getMargins() -> SegmentItemView.ViewProperties.Margins {
        return .init(
            height: size.height(),
            textInsets: size.textInsets(),
            dividerInsets: size.dividerInsets(),
            dividerHeight: size.dividerHeight()
        )
    }
    
    private func tintColor() -> UIColor {
        switch selected {
        case .true: state.tintSelectedOnStyleColor()
        case .false: state.tintSelectedOffStyleColor()
        }
    }
    
    private func backgroundColor() -> UIColor {
        switch selected {
        case .true: state.backgroundSelectedOnStyleColor()
        case .false: state.backgroundSelectedOffStyleColor()
        }
    }
}

// MARK: - SegmentItemViewStyle.State Extension

public extension SegmentItemViewStyle.State {
    
    func tintSelectedOnStyleColor() -> UIColor {
        switch self {
        case .default: .Components.SegmentItem.Selected.Label.Color.default
        case .pressed: .Components.SegmentItem.Selected.Label.Color.pressed
        }
    }
    
    func tintSelectedOffStyleColor() -> UIColor {
        switch self {
        case .default: .Components.SegmentItem.Default.Label.Color.default
        case .pressed: .Components.SegmentItem.Default.Label.Color.pressed
        }
    }
    
    func backgroundSelectedOnStyleColor() -> UIColor {
        switch self {
        case .default: .Components.SegmentItem.Selected.Background.Color.default
        case .pressed: .Components.SegmentItem.Selected.Background.Color.pressed
        }
    }
    
    func backgroundSelectedOffStyleColor() -> UIColor {
        switch self {
        case .default: .Components.SegmentItem.Default.Background.Color.default
        case .pressed: .Components.SegmentItem.Default.Background.Color.pressed
        }
    }
}

// MARK: - SegmentItemViewStyle.ShowDivider Extension

public extension SegmentItemViewStyle.ShowDivider {
    
    func isDividerHidden() -> Bool {
        switch self {
        case .true: false
        case .false: true
        }
    }
}

// MARK: - SegmentItemViewStyle.Size Extension

public extension SegmentItemViewStyle.Size {
    
    func fontStyle() -> FontStyle {
        switch self {
        case .sizeS: .textS
        case .sizeL: .textM
        }
    }
    
    func height() -> CGFloat {
        switch self {
        case .sizeS: 24
        case .sizeL: 32
        }
    }
    
    func textInsets() -> UIEdgeInsets {
        switch self {
        case .sizeS: .init(top: 2, left: 8, bottom: 2, right: 8)
        case .sizeL: .init(top: 4, left: 8, bottom: 4, right: 8)
        }
    }
    
    func dividerInsets() -> UIEdgeInsets {
        switch self {
        case .sizeS: .zero
        case .sizeL: .init(top: 4, left: .zero, bottom: 4, right: .zero)
        }
    }
    
    func dividerHeight() -> CGFloat {
        24
    }
    
    func cornerRadius() -> CGFloat {
        switch self {
        case .sizeS, .sizeL: 6
        }
    }
}
