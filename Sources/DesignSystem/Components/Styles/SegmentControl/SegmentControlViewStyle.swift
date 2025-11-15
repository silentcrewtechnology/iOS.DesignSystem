import UIKit
import Colors
import Components

public final class SegmentControlViewStyle {
    
    // MARK: - Properties
    
    private typealias ViewProperties = SegmentControlView.ViewProperties
    
    public enum Size {
        case small
        case large
    }
    
    public enum Background {
        case primary
        case secondary
    }
    
    // MARK: - Private properties
    
    private var background: Background
    private var size: Size
    
    // MARK: - Init
    
    public init(
        background: Background,
        size: Size
    ) {
        self.background = background
        self.size = size
    }
    
    // MARK: - Methods
    
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
        viewProperties.cornerRadius = self.size.cornerRadius()
        viewProperties.margins = getMargins()
    }
    
    // MARK: - Private properties
    
    private func getMargins() -> SegmentControlView.ViewProperties.Margins {
        return .init(
            insets: size.insets(),
            height: size.height()
        )
    }
}

// MARK: - SegmentControlViewStyle.Background Extension

public extension SegmentControlViewStyle.Background {
    
    func color() -> UIColor {
        switch self {
        case .primary: .Components.Segment.Primary.Background.Color.default
        case .secondary: .Components.Segment.Secondary.Background.Color.default
        }
    }
}

public extension SegmentControlViewStyle.Size {
    
    func insets() -> UIEdgeInsets {
        switch self {
        case .small, .large: .init(top: 4, left: 4, bottom: 4, right: 4)
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
