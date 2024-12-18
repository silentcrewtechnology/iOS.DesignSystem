import UIKit
import Components
import ImagesService

public final class RadioViewStyle {
    
    // MARK: - Properties
    
    public enum State {
        case `default`
        case pressed
        case disabled
    }
    
    public enum Selection: String {
        case off
        case on
    }
    
    public private(set) var selection: Selection
    
    // MARK: - Private properties
    
    private var state: State
    
    // MARK: - Init
    
    public init(
        state: State,
        selection: Selection
    ) {
        self.state = state
        self.selection = selection
    }
    
    // MARK: - Methods
    
    public func update(
        state: State? = nil,
        selection: Selection? = nil,
        viewProperties: inout RadioView.ViewProperties
    ) {
        if let state {
            self.state = state
        }
        
        if let selection {
            self.selection = selection
        }
        
        viewProperties.backgroundColor = backgroundColor()
        viewProperties.size = .init(width: 20, height: 20)
        viewProperties.cornerRadius = viewProperties.size.width / 2
        viewProperties.borderWidth = borderWidth()
        viewProperties.borderColor = borderColor()
        viewProperties.checkIcon = checkIcon()
        viewProperties.isUserInteractionEnabled = self.state != .disabled
    }
}

// MARK: - RadioViewStyle Extension

extension RadioViewStyle {
    
    private func backgroundColor() -> UIColor {
        switch selection {
        case .off: backgroundSelectionDefaultColor()
        case .on: backgroundSelectionCheckedColor()
        }
    }
    
    private func backgroundSelectionDefaultColor() -> UIColor {
        switch state {
        case .default: .Components.Radio.Default.Background.Color.default
        case .pressed: .Components.Radio.Default.Background.Color.pressed
        case .disabled: .Components.Radio.Default.Background.Color.disabled
        }
    }
    
    private func backgroundSelectionCheckedColor() -> UIColor {
        switch state {
        case .default: .Components.Radio.Checked.Background.Color.default
        case .pressed: .Components.Radio.Checked.Background.Color.pressed
        case .disabled: .Components.Radio.Checked.Background.Color.disabled
        }
    }
    
    private func borderWidth() -> CGFloat {
        switch selection {
        case .off: 1
        case .on: 0
        }
    }
    
    private func borderColor() -> UIColor {
        switch selection {
        case .off: borderSelectionDefaultColor()
        case .on: borderSelectionCheckedColor()
        }
    }
    
    private func borderSelectionDefaultColor() -> UIColor {
        switch state {
        case .default: .Components.Radio.Default.Border.Color.default
        case .pressed: .Components.Radio.Default.Border.Color.pressed
        case .disabled: .Components.Radio.Default.Border.Color.disabled
        }
    }
    
    private func borderSelectionCheckedColor() -> UIColor {
        switch state {
        case .default: .Components.Radio.Checked.Border.Color.default
        case .pressed: .Components.Radio.Checked.Border.Color.pressed
        case .disabled: .Components.Radio.Checked.Border.Color.disabled
        }
    }
    
    private func checkIcon() -> UIImage? {
        switch selection {
        case .off: return nil
        case .on: return .ic10Radio.withTintColor(iconCheckedColor())
        }
    }
    
    private func iconCheckedColor() -> UIColor {
        switch state {
        case .default: .Components.Radio.Checked.CheckIcon.Color.default
        case .pressed: .Components.Radio.Checked.CheckIcon.Color.pressed
        case .disabled: .Components.Radio.Checked.CheckIcon.Color.disabled
        }
    }
}
