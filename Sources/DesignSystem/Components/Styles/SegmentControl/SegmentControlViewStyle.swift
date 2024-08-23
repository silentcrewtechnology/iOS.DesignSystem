import UIKit
import Colors
import Components

public class SegmentControlViewStyle {
    
    private typealias ViewProperties = SegmentControlView.ViewProperties
    
    public enum Size {
        case small
        case large
    }
    
    public enum Background {
        case primary
        case secondary
    }
    
    private var background: Background
    private var size: Size
    private var segmentItemStyle: SegmentItemViewStyle
    
    public init(
        background: Background,
        size: Size,
        segmentItemStyle: SegmentItemViewStyle = .init()
    ) {
        self.background = background
        self.size = size
        self.segmentItemStyle = segmentItemStyle
    }
    
    public func update(
        background: Background? = nil,
        size: Size? = nil,
        viewProperties: inout SegmentControlView.ViewProperties
    ) {
        if let background {
            self.background = background
        }
        
        if let size {
            self.size = size
        }
        
        viewProperties.backgroundColor = self.background.color()
        viewProperties.margins = getMargins()
        viewProperties.cornerRadius = self.size.cornerRadius()
    }
    
    private func getMargins() -> SegmentControlView.ViewProperties.Margins {
        return .init(
            top: size.top(),
            bottom: size.bottom(),
            leading: size.leading(),
            trailing: size.trailing(),
            height: size.height())
    }
}

public extension SegmentControlViewStyle.Background {
    func color() -> UIColor {
        switch self {
        case .primary: .Components.Segment.Primary.Background.Color.default
        case .secondary: .Components.Segment.Secondary.Background.Color.default
        }
    }
}

public extension SegmentControlViewStyle.Size {
    func top() -> CGFloat {
        switch self {
        case .small: 4
        case .large: 4
        }
    }
    
    func bottom() -> CGFloat {
        switch self {
        case .small: 4
        case .large: 4
        }
    }
    
    func leading() -> CGFloat {
        switch self {
        case .small: 4
        case .large: 4
        }
    }
    
    func trailing() -> CGFloat {
        switch self {
        case .small: 4
        case .large: 4
        }
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
    
    func cornerRadius() -> CGFloat {
        switch self {
        case .small: 8
        case .large: 8
        }
    }
}
