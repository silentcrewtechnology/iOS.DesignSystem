import UIKit
import Components

public protocol LabelViewServiceProtocol {
    var view: LabelView { get }
    var viewProperties: LabelView.ViewProperties { get }
    var style: LabelViewStyle { get }
    
    func update(
        with parameters: LabelViewService.LabelUpdateParameters?
    )
}

public final class LabelViewService: LabelViewServiceProtocol {
    
    // MARK: - Properties
    
    public private(set) var view: LabelView
    public private(set) var viewProperties: LabelView.ViewProperties
    public private(set) var style: LabelViewStyle
    
    // MARK: - Init
    
    public init(
        view: LabelView = .init(),
        viewProperties: LabelView.ViewProperties = .init(),
        style: LabelViewStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        
        update()
    }
    
    // MARK: - UpdateParameters
    
    public struct LabelUpdateParameters {
        public var newVariant: LabelViewStyle.Variant?
        public var newText: NSMutableAttributedString?
        
        public init(
            newVariant: LabelViewStyle.Variant? = nil,
            newText: NSMutableAttributedString? = nil
        ) {
            self.newVariant = newVariant
            self.newText = newText
        }
    }
    
    // MARK: - Methods
    
    public func update(
        with parameters: LabelUpdateParameters? = nil
    ) {
        if let newText = parameters?.newText {
            viewProperties.text = newText
        }
        
        style.update(
            variant: parameters?.newVariant,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
}

extension LabelViewService {
    @available(*, deprecated, message: "Use  update(with parameters:")
    public func update(
        newVariant: LabelViewStyle.Variant? = nil,
        newText: NSMutableAttributedString? = nil
    ) {
        update(with: .init(
            newVariant: newVariant,
            newText: newText
        ))
    }
}
