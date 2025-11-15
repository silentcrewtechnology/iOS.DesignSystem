import UIKit
import Components

public protocol ButtonViewServiceProtocol {
    var view: ButtonView { get }
    var viewProperties: ButtonView.ViewProperties { get }
    var style: ButtonViewStyle { get }
    var loaderService: LoaderViewService { get }
    
    func update(
        with parameters: ButtonViewService.ButtonUpdateParameters?
    )
}

public final class ButtonViewService: ButtonViewServiceProtocol {
    
    // MARK: - Properties
    
    public private(set) var view: ButtonView
    public private(set) var viewProperties: ButtonView.ViewProperties
    public private(set) var style: ButtonViewStyle
    public private(set) lazy var loaderService: LoaderViewService = .init(
        style: .init(color: .main, size: .s),
        isHidden: true
    )
    
    // MARK: - Init
    
    public init(
        view: ButtonView = .init(),
        viewProperties: ButtonView.ViewProperties = .init(),
        style: ButtonViewStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        
        self.viewProperties.loader = self.loaderService.view
        update()
    }
    
    // MARK: - UpdateParameters
    
    public struct ButtonUpdateParameters {
        public var newSize: ButtonViewStyle.Size?
        public var newColor: ButtonViewStyle.Color?
        public var newVariant: ButtonViewStyle.Variant?
        public var newState: ButtonViewStyle.State?
        public var newIcon: ButtonViewStyle.Icon?
        public var newText: NSMutableAttributedString?
        public var newOnTap: (() -> Void)?
        
        public init(
            newSize: ButtonViewStyle.Size? = nil,
            newColor: ButtonViewStyle.Color? = nil,
            newVariant: ButtonViewStyle.Variant? = nil,
            newState: ButtonViewStyle.State? = nil,
            newIcon: ButtonViewStyle.Icon? = nil,
            newText: NSMutableAttributedString? = nil,
            newOnTap: (() -> Void)? = nil
        ) {
            self.newSize = newSize
            self.newColor = newColor
            self.newVariant = newVariant
            self.newState = newState
            self.newIcon = newIcon
            self.newText = newText
            self.newOnTap = newOnTap
        }
    }
    
    // MARK: - Methods
    
    public func update(
        with parameters: ButtonUpdateParameters? = nil
    ) {
        if let newText = parameters?.newText {
            viewProperties.attributedText = newText
        }
        
        if let newOnTap = parameters?.newOnTap {
            viewProperties.onTap = newOnTap
        }
        
        style.update(
            size: parameters?.newSize,
            color: parameters?.newColor,
            variant: parameters?.newVariant,
            state: parameters?.newState,
            icon: parameters?.newIcon,
            viewProperties: &viewProperties
        )
        let isHidden: Bool = {
            guard let newState = parameters?.newState else { return loaderService.viewProperties.isHidden }
            return newState != .loading
        }()
        loaderService.update(newStyle: style.loaderStyle(), isHidden: isHidden)
        view.update(with: viewProperties)
    }
    
    // MARK: - Private methods
}

extension ButtonViewService {
    @available(*, deprecated, message: "Use  update(with parameters:")
    public func update(
        newSize: ButtonViewStyle.Size? = nil,
        newColor: ButtonViewStyle.Color? = nil,
        newVariant: ButtonViewStyle.Variant? = nil,
        newState: ButtonViewStyle.State? = nil,
        newIcon: ButtonViewStyle.Icon? = nil,
        newText: NSMutableAttributedString? = nil,
        newOnTap: (() -> Void)? = nil
    ) {
        update(with: .init(
            newSize: newSize,
            newColor: newColor,
            newVariant: newVariant,
            newState: newState,
            newIcon: newIcon,
            newText: newText,
            newOnTap: newOnTap
        ))
    }
}
