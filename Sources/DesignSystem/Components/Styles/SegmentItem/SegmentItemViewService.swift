import UIKit
import Components

public final class SegmentItemViewService {
    
    // MARK: - Properties
    
    public private(set) var view: SegmentItemView
    public private(set) var viewProperties: SegmentItemView.ViewProperties
    public private(set) var style: SegmentItemViewStyle
    public private(set) var dividerService = DividerViewService(
        style: .init(variant: .vertical, style: .main)
    )
    
    // MARK: - Init
    
    public init(
        view: SegmentItemView = .init(),
        viewProperties: SegmentItemView.ViewProperties = .init(),
        style: SegmentItemViewStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        
        self.viewProperties.divider = dividerService.view
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newSize: SegmentItemViewStyle.Size? = nil,
        newState: SegmentItemViewStyle.State? = nil,
        newSelected: SegmentItemViewStyle.Selected? = nil,
        newShowDivider: SegmentItemViewStyle.ShowDivider? = nil,
        newText: NSMutableAttributedString? = nil,
        newOnItemTap: ((Bool) -> Void)? = nil,
        newHandlePress: ((PressableView.State) -> Void)? = nil
    ) {
        if let newText {
            viewProperties.text = newText
        }
        
        if let newOnItemTap {
            viewProperties.onItemTap = newOnItemTap
        }
        
        if let newHandlePress {
            viewProperties.handlePress = newHandlePress
        }
        
        style.update(
            size: newSize,
            state: newState,
            selected: newSelected,
            showDivider: newShowDivider,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
}
