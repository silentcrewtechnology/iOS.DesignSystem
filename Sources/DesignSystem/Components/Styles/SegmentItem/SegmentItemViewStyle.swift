import UIKit
import Colors
import Components

public class SegmentItemViewStyle {
    
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
    
    private var size: Size
    private var state: State
    private var selected: Selected
    private var showDivider: ShowDivider
    private var dividerStyle: DividerViewStyle
    
    public init(
        size: Size = .sizeS,
        state: State = .default,
        selected: Selected = .false,
        showDivider: ShowDivider = .true,
        dividerStyle: DividerViewStyle = .init(variant: .vertical, style: .main)
    ) {
        self.size = size
        self.state = state
        self.selected = selected
        self.showDivider = showDivider
        self.dividerStyle = dividerStyle
    }
    
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
        
        viewProperties.backgroundColor = backgroundColor(state: self.state, selected: self.selected)
        viewProperties.cornerRadius = self.size.cornerRadius()
        viewProperties.text = viewProperties.text.string.fontStyle(self.size.fontStyle())
        viewProperties.textColor = tintColor(state: self.state,
                                             selected: self.selected)
        dividerStyle.update(viewProperties: &viewProperties.divider)
        viewProperties.isDividerHidden = self.showDivider.isDividerHidden()
        viewProperties.margins = getMargins()
    }
    
    private func getMargins() -> SegmentItemView.ViewProperties.Margins {
        return .init(
            height: size.height(),
            textLeading: size.textLeading(),
            textTrailing: size.textTrailing(),
            textTop: size.textTop(),
            textBottom: size.textBottom(),
            dividerTop: size.dividerTop(),
            dividerTrailing: size.dividerTrailing(),
            dividerBottom: size.dividerBottom())
    }
}

extension SegmentItemViewStyle {
    private func tintColor(
        state: State,
        selected: Selected
    ) -> UIColor {
        switch selected {
        case .true: tintSelectedOnStyleColor(state: state)
        case .false: tintSelectedOffStyleColor(state: state)
        }
    }
    
    private func tintSelectedOnStyleColor(
        state: State
    ) -> UIColor {
        switch state {
        case .default:
                .Components.SegmentItem.Selected.Label.Color.default
        case .pressed:
                .Components.SegmentItem.Selected.Label.Color.pressed
        }
    }
    
    private func tintSelectedOffStyleColor(
        state: State
    ) -> UIColor {
        switch state {
        case .default:
                .Components.SegmentItem.Default.Label.Color.default
        case .pressed:
                .Components.SegmentItem.Default.Label.Color.pressed
        }
    }
}

extension SegmentItemViewStyle {
    private func backgroundColor(
        state: State,
        selected: Selected
    ) -> UIColor {
        switch selected {
        case .true: backgroundSelectedOnStyleColor(state: state)
        case .false: backgroundSelectedOffStyleColor(state: state)
        }
    }
    
    private func backgroundSelectedOnStyleColor(
        state: State
    ) -> UIColor {
        switch state {
        case .default: .Components.SegmentItem.Selected.Background.Color.default
        case .pressed: .Components.SegmentItem.Selected.Background.Color.pressed
        }
    }
    
    private func backgroundSelectedOffStyleColor(
        state: State
    ) -> UIColor {
        switch state {
        case .default: .Components.SegmentItem.Default.Background.Color.default
        case .pressed: .Components.SegmentItem.Default.Background.Color.pressed
        }
    }
}

extension SegmentItemViewStyle.ShowDivider {
    func isDividerHidden() -> Bool {
        switch self {
        case .true: false
        case .false: true
        }
    }
}

extension SegmentItemViewStyle.Size {
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
    
    func textTop() -> CGFloat {
        switch self {
        case .sizeS: 2
        case .sizeL: 4
        }
    }
    
    func textLeading() -> CGFloat {
        switch self {
        case .sizeS: 8
        case .sizeL: 8
        }
    }
    
    func textTrailing() -> CGFloat {
        switch self {
        case .sizeS: 8
        case .sizeL: 8
        }
    }
    
    func textBottom() -> CGFloat {
        switch self {
        case .sizeS: 2
        case .sizeL: 4
        }
    }
    
    func dividerTop() -> CGFloat {
        switch self {
        case .sizeS: 0
        case .sizeL: 4
        }
    }
    
    func dividerTrailing() -> CGFloat {
        switch self {
        case .sizeS: 0
        case .sizeL: 0
        }
    }
    
    func dividerBottom() -> CGFloat {
        switch self {
        case .sizeS: 0
        case .sizeL: 4
        }
    }
    
    func cornerRadius() -> CGFloat {
        switch self {
        case .sizeS: 6
        case .sizeL: 6
        }
    }
}
