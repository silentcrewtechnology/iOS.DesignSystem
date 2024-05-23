import Components
import UIKit

public struct DSAtomStyleService {
    public func createAtom(_ dsAtom: AtomDSElement) -> UIView? {
        switch dsAtom {
        case .title(let text, let style):
            return createTitle(text, style)
        case .subtitle(let text, let style):
            return createSubtitle(text, style)
        case .image40(let image, let style):
            return createImage40(image, style)
        case .card(let backgroundImage, let style):
            return createCard(backgroundImage, style)
        case .index(let text, let style):
            return createIndex(text, style)
        case .icon24(let image, let style):
            return createIcon24(image, style)
        case .icon20(let image, let style):
            return createIcon20(image, style)
        case .toggle(let isOn, let action, let style):
            return createToggle(isOn: isOn, action: action, style: style)
        case .amountText(let text, let style):
            return createAmountText(text, style)
        case .checkbox(let isOn, let action, let style):
            return createCheckbox(isOn: isOn, action: action, style: style)
        case .radio(let isOn, let action, let style):
            return createRadio(isOn: isOn, action: action, style: style)
        case .button(let text, let action, let style):
            return createButton(text: text, action: action, style: style)
        case .copyText(let text, let style):
            return createCopyText(text, style)
        }
    }
}

private extension DSAtomStyleService {
    private func createTitle(
        _ text: String,
        _ style: LabelViewStyle?
    ) -> UIView? {
        var viewProperties = LabelView.ViewProperties(text: text.attributed)
        
        let newStyle = style ?? LabelViewStyle(variant: .title)
        newStyle.update(viewProperties: &viewProperties)
        
        let title = RowBlocksService.createRowBlock(.atom(.title(viewProperties)))
        return title
    }
    
    private func createSubtitle(
        _ text: String,
        _ style: LabelViewStyle?
    ) -> UIView? {
        var viewProperties = LabelView.ViewProperties(text: text.attributed)
        
        let newStyle = style ?? LabelViewStyle(variant: .subtitle)
        newStyle.update(viewProperties: &viewProperties)
        
        let subtitle = RowBlocksService.createRowBlock(.atom(.subtitle(viewProperties)))
        return subtitle
    }
    
    private func createImage40(
        _ image: UIImage,
        _ style: ImageViewStyle?
    ) -> UIView? {
        var viewProperties = ImageView.ViewProperties(image: image)
        
        let newStyle = style ?? ImageViewStyle(
            variant: .image(image),
            color: .primary
        )
        newStyle.update(viewProperties: &viewProperties)
        
        let imageView = RowBlocksService.createRowBlock(.atom(.image40(viewProperties)))
        return imageView
    }

    private func createCard(
        _ backgroundImage: UIImage,
        _ style: CardImageViewStyle?
    ) -> UIView? {
        var viewProperties = CardImageView.ViewProperties()
        
        let newStyle = style ?? CardImageViewStyle(
            paymentSystem: .Mir,
            backgroundImage: backgroundImage)
        newStyle.update(viewProperties: &viewProperties)
        
        let cardView = RowBlocksService.createRowBlock(.atom(.card(viewProperties)))
        return cardView
    }
    
    private func createIndex(
        _ text: String,
        _ style: LabelViewStyle?
    ) -> UIView? {
        let attributed = text.attributed.alignment(.right)
        var viewProperties = LabelView.ViewProperties(text: attributed)
        
        let newStyle = style ?? LabelViewStyle(variant: .index)
        newStyle.update(viewProperties: &viewProperties)
        
        let index = RowBlocksService.createRowBlock(.atom(.index(viewProperties)))
        return index
    }
    
    private func createIcon24(
        _ image: UIImage,
        _ style: ImageViewStyle?
    ) -> UIView? {
        var viewProperties = ImageView.ViewProperties(image: image)
        
        let newStyle = style ?? ImageViewStyle(
            variant: .icon24(image),
            color: .primary
        )
        newStyle.update(viewProperties: &viewProperties)
        
        let imageView = RowBlocksService.createRowBlock(.atom(.image40(viewProperties)))
        return imageView
    }
    
    private func createIcon20(
        _ image: UIImage,
        _ style: ImageViewStyle?
    ) -> UIView? {
        var viewProperties = ImageView.ViewProperties(image: image)
        
        let newStyle = style ?? ImageViewStyle(
            variant: .icon20(image),
            color: .primary
        )
        newStyle.update(viewProperties: &viewProperties)
        
        let imageView = RowBlocksService.createRowBlock(.atom(.image40(viewProperties)))
        return imageView
    }
    
    private func createToggle(
        isOn: Bool,
        action: @escaping (Bool) -> Void,
        style: ToggleViewStyle?
    ) -> UIView? {
        var viewProperties = ToggleView.ViewProperties(
            isChecked: isOn,
            checkAction: action
        )
        
        let newStyle = style ?? ToggleViewStyle(state: .default)
        newStyle.update(viewProperties: &viewProperties)
        
        let toggle = RowBlocksService.createRowBlock(.atom(.toggle(viewProperties)))
        return toggle
    }
    
    private func createAmountText(
        _ text: String,
        _ style: LabelViewStyle?
    ) -> UIView? {
        var viewProperties = LabelView.ViewProperties(text: text.attributed)
        
        let newStyle = style ?? LabelViewStyle(variant: .amount)
        newStyle.update(viewProperties: &viewProperties)
        
        let amountText = RowBlocksService.createRowBlock(.atom(.amountText(viewProperties)))
        return amountText
    }
    
    //TODO: прокинуть action - обсудить на pbr
    private func createCheckbox(
        isOn: Bool,
        action: () -> Void,
        style: CheckboxViewStyle?
    ) -> UIView? {
        var viewProperties = CheckboxView.ViewProperties()
        
        let newStyle = style ?? CheckboxViewStyle(
            size: .sizeL,
            state: .default,
            action: isOn ? .on : .off
        )
        newStyle.update(viewProperties: &viewProperties)
        
        let checkbox = RowBlocksService.createRowBlock(.atom(.checkbox(viewProperties)))
        return checkbox
    }
    
    private func createRadio(
        isOn: Bool,
        action: @escaping () -> Void,
        style: RadioViewStyle? = nil
    ) -> UIView? {
        var style = style ?? RadioViewStyle(
            selection: isOn ? .checked : .default,
            state: .default
        )
        // TODO: нужна сущность, чтобы хранить ссылки на View/ViewProperties
        var updateView: (RadioViewStyle) -> Void = { _ in }
        var viewProperties = RadioView.ViewProperties(
            onPressChange: { state in
                switch state {
                case .pressed:
                    style.state = .pressed
                case .unpressed:
                    switch style.selection {
                    case .default:
                        style.selection = .checked
                        action()
                    case .checked: break // already checked
                    }
                    style.state = .default
                case .cancelled:
                    style.state = .default
                }
                updateView(style)
            }
        )
        style.update(viewProperties: &viewProperties)
        let radio = RowBlocksService.createRowBlock(.atom(.radio(viewProperties)))
        updateView = { style in
            style.update(viewProperties: &viewProperties)
            (radio as? RadioView)?.update(with: viewProperties)
        }
        return radio
    }
    
    //TODO: прокинуть action - обсудить на pbr
    private func createButton(
        text: String,
        action: () -> Void,
        style: ButtonViewStyle?
    ) -> UIView? {
        var viewProperties = ButtonView.ViewProperties(attributedText: text.attributed)
        
        let newStyle = style ?? ButtonViewStyle(
            context: .action(.contained),
            state: .default,
            size: .sizeXS
        )
        newStyle.update(viewProperties: &viewProperties)
        
        let button = RowBlocksService.createRowBlock(.atom(.button(viewProperties)))
        return button
    }
    
    //TODO: обсудить на pbr создание отдельного компонента ДС
    private func createCopyText(
        _ text: String,
        _ style: LabelViewStyle?
    ) -> UIView? {
        var viewProperties = LabelView.ViewProperties(text: text.attributed)
        
        let newStyle = style ?? LabelViewStyle(variant: .default)
        newStyle.update(viewProperties: &viewProperties)
        
        let copyText = RowBlocksService.createRowBlock(.atom(.copyText(viewProperties)))
        return copyText
    }
}
