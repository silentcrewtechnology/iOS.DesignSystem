import UIKit
import Components

public final class TileViewStyle {
    
    // MARK: - Properties
    
    public enum Background {
        case primary
        case main
        case transparency
        case square(UIImage)
    }
    
    public enum Size {
        case s
        case m
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
        viewProperties: inout TileView.ViewProperties
    ) {
        if let background {
            self.background = background
        }
        
        if let size {
            self.size = size
        }
        
        viewProperties.backgroundColor = self.background.backgroundColor()
        viewProperties.size = self.size.size()
        viewProperties.imageSize = self.background.imageSize()
        viewProperties.cornerRadius = 12
        viewProperties.imageCornerRadius = 16
        viewProperties.imageInsets = imageInsets()
        viewProperties.textInsets = .init(top: 8, left: 8, bottom: 16, right: 8)
        viewProperties.shouldUseImageSize = self.background.shouldUseImageSize()
        viewProperties.isFloatingHeight = self.size == .m
        viewProperties.text = viewProperties.text
            .fontStyle(.textXS)
            .foregroundColor(self.background.textColor())
            .alignment(.center)
    }
    
    // MARK: - Private methods
    
    private func imageInsets() -> UIEdgeInsets {
        switch size {
        case .s: .init(top: 16, left: 20, bottom: .zero, right: 20)
        case .m: background.imageInsets()
        }
    }
}

// MARK: - TileViewStyle.Background Extension

public extension TileViewStyle.Background {
    
    func backgroundColor() -> UIColor {
        switch self {
        case .primary: .Components.Tile.Primary.Background.Color.default
        case .main: .Components.Tile.Main.Background.Color.default
        case .transparency: .Components.Tile.Transparency.Background.Color.default
        case .square: .Components.Tile.Square.Background.Color.default
        }
    }
    
    func textColor() -> UIColor {
        switch self {
        case .primary: .Components.Tile.Primary.Label.Color.default
        case .main: .Components.Tile.Main.Label.Color.default
        case .transparency: .Components.Tile.Transparency.Label.Color.default
        case .square: .Components.Tile.Square.Label.Color.default
        }
    }
    
    func imageInsets() -> UIEdgeInsets {
        switch self {
        case .square: .init(top: 16, left: 20, bottom: .zero, right: 20)
        default: .init(top: 16, left: 28, bottom: .zero, right: 28)
        }
    }
    
    func imageSize() -> CGSize {
        switch self {
        case .square: .init(width: 56, height: 56)
        default: .init(width: 40, height: 40)
        }
    }
    
    func shouldUseImageSize() -> Bool {
        switch self {
        case .square: true
        default: false
        }
    }
}

// MARK: - TileViewStyle.Size Extension

public extension TileViewStyle.Size {

    func size() -> CGSize {
        switch self {
        case .s: .init(width: 80, height: 96)
        case .m: .init(width: 96, height: 72)
        }
    }
}
