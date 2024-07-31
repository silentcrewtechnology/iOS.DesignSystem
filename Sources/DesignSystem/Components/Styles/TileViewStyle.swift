import UIKit
import Components

public final class TileViewStyle {
    
    public enum Background {
        case primary
        case main
    }
    
    public enum WidthType {
        case s
        case m
    }
    
    private var background: Background
    private var widthType: WidthType
    
    public init(
        background: Background,
        widthType: WidthType
    ) {
        self.background = background
        self.widthType = widthType
    }
    
    public func update(
        background: Background? = nil,
        widthType: WidthType? = nil,
        viewProperties: inout TileView.ViewProperties
    ) {
        
        if let background {
            self.background = background
        }
        
        if let widthType {
            self.widthType = widthType
        }
        
        viewProperties.backgroundColor = self.background.backgroundColor()
        viewProperties.text = viewProperties.text
            .fontStyle(.textXS)
            .foregroundColor(self.background.textColor())
            .alignment(.center)
        viewProperties.cornerRadius = 12
        viewProperties.numberOfLines = self.widthType.numberOfLines()
        viewProperties.margins = getMargins()
    }
    
    private func getMargins() -> TileView.ViewProperties.Margins {
        return .init(
            imageTop: 16,
            labelTop: 8,
            labelBottom: 16,
            labelLeading: 8,
            labelTrailing: 8,
            width: widthType.width()
        )
    }
}

public extension TileViewStyle.Background {
    func backgroundColor() -> UIColor {
        switch self {
        case .primary: .Components.Tile.Primary.Background.Color.default
        case .main: .Components.Tile.Main.Background.Color.default
        }
    }
    
    func textColor() -> UIColor {
        switch self {
        case .primary: .Components.Tile.Primary.Label.Color.default
        case .main: .Components.Tile.Main.Label.Color.default
        }
    }
}

public extension TileViewStyle.WidthType {
    func numberOfLines() -> Int {
        switch self {
        case .s: return 1
        case .m: return 2
        }
    }
    
    func width() -> CGFloat {
        switch self {
        case .s: return 80
        case .m: return 96
        }
    }
}
