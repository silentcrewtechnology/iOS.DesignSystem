import Components
import UIKit

public struct DSAtomStyleService {
    public func createAtom(_ dsAtom: AtomDSElement) -> UIView? {
        switch dsAtom {
        case .title(let text, let style, let recognizer):
            return createTitle(text, style, recognizer)
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
        case .label(let text, let style):
            return createLabel(text, style)
        case .buttonIcon(let image, let onTap, let style):
            return createButtonIcon(image, onTap, style)
        case .titleView(let title, let style):
            return createTitleView(title, style)
        }
    }
}

private extension DSAtomStyleService {
    private func createTitle(
        _ text: String,
        _ style: LabelViewStyle?,
        _ recognizer: UILongPressGestureRecognizer?
    ) -> UIView? {
        var viewProperties = LabelView.ViewProperties(text: text.attributed)
        
        let newStyle = style ?? LabelViewStyle(variant: .rowTitle(recognizer: recognizer))
        newStyle.update(viewProperties: &viewProperties)
        
        let title = RowBlocksService().createRowBlock(.atom(.title(viewProperties)))
        return title
    }
    
    private func createSubtitle(
        _ text: String,
        _ style: LabelViewStyle?
    ) -> UIView? {
        var viewProperties = LabelView.ViewProperties(text: text.attributed)
        
        let newStyle = style ?? LabelViewStyle(variant: .rowSubtitle)
        newStyle.update(viewProperties: &viewProperties)
        
        let subtitle = RowBlocksService().createRowBlock(.atom(.subtitle(viewProperties)))
        return subtitle
    }
    
    private func createImage40(
        _ image: UIImage,
        _ style: ImageViewStyle?
    ) -> UIView? {
        var viewProperties = ImageView.ViewProperties(image: image)
        
        let newStyle = style ?? ImageViewStyle(
            type: .icon(image),
            color: .primary
        )
        newStyle.update(viewProperties: &viewProperties)
        
        let imageView = RowBlocksService().createRowBlock(.atom(.image40(viewProperties)))
        return imageView
    }

    private func createCard(
        _ backgroundImage: UIImage,
        _ style: CardViewStyle?
    ) -> UIView? {
        var viewProperties = CardView.ViewProperties()
        
        let newStyle = style ?? CardViewStyle(
            set: .mir,
            size: .small,
            stack: .false
        )
        newStyle.update(viewProperties: &viewProperties, backgroundImage: backgroundImage)
        
        let cardView = RowBlocksService().createRowBlock(.atom(.card(viewProperties)))
        return cardView
    }
    
    private func createIndex(
        _ text: String,
        _ style: LabelViewStyle?
    ) -> UIView? {
        let attributed = text.attributed.alignment(.right)
        var viewProperties = LabelView.ViewProperties(text: attributed)
        
        let newStyle = style ?? LabelViewStyle(variant: .rowIndex)
        newStyle.update(viewProperties: &viewProperties)
        
        let index = RowBlocksService().createRowBlock(.atom(.index(viewProperties)))
        return index
    }
    
    private func createIcon24(
        _ image: UIImage,
        _ style: ImageViewStyle?
    ) -> UIView? {
        var viewProperties = ImageView.ViewProperties(image: image)
        
        let newStyle = style ?? ImageViewStyle(
            type: .custom(image, .init(width: 24, height: 24)),
            color: .primary
        )
        newStyle.update(viewProperties: &viewProperties)
        
        let imageView = RowBlocksService().createRowBlock(.atom(.image40(viewProperties)))
        return imageView
    }
    
    private func createIcon20(
        _ image: UIImage,
        _ style: ImageViewStyle?
    ) -> UIView? {
        var viewProperties = ImageView.ViewProperties(image: image)
        
        let newStyle = style ?? ImageViewStyle(
            type: .custom(image, .init(width: 20, height: 20)),
            color: .primary
        )
        newStyle.update(viewProperties: &viewProperties)
        
        let imageView = RowBlocksService().createRowBlock(.atom(.image40(viewProperties)))
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
        
        let toggle = RowBlocksService().createRowBlock(.atom(.toggle(viewProperties)))
        return toggle
    }
    
    private func createAmountText(
        _ text: String,
        _ style: LabelViewStyle?
    ) -> UIView? {
        var viewProperties = LabelView.ViewProperties(text: text.attributed)
        
        let newStyle = style ?? LabelViewStyle(variant: .rowAmount)
        newStyle.update(viewProperties: &viewProperties)
        
        let amountText = RowBlocksService().createRowBlock(.atom(.amountText(viewProperties)))
        return amountText
    }
    
    private func createCheckbox(
        isOn: Bool,
        action: @escaping (Bool) -> Void,
        style: CheckboxViewStyle?
    ) -> UIView? {
        var style = style ?? CheckboxViewStyle(
            selection: isOn ? .checked : .default,
            state: .default
        )
        // TODO: нужна сущность, чтобы хранить ссылки на View/ViewProperties
        var updateView: (CheckboxViewStyle) -> Void = { _ in }
        var viewProperties = CheckboxView.ViewProperties(
            onPressChange: { state in
                switch state {
                case .pressed:
                    style.state = .pressed
                case .unpressed:
                    switch style.selection {
                    case .default:
                        style.selection = .checked
                        action(true)
                    case .checked:
                        style.selection = .default
                        action(false)
                    }
                    style.state = .default
                case .cancelled:
                    style.state = .default
                }
                updateView(style)
            })
        style.update(viewProperties: &viewProperties)
        
        let checkbox = RowBlocksService().createRowBlock(.atom(.checkbox(viewProperties)))
        updateView = { style in
            style.update(viewProperties: &viewProperties)
            (checkbox as? CheckboxView)?.update(with: viewProperties)
        }
        return checkbox
    }
    
    private func createRadio(
        isOn: Bool,
        action: @escaping () -> Void,
        style: RadioViewStyle? = nil
    ) -> UIView? {
        let style = style ?? RadioViewStyle(
            state: .default,
            selection: isOn ? .checked : .default
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
        let radio = RowBlocksService().createRowBlock(.atom(.radio(viewProperties)))
        updateView = { style in
            style.update(viewProperties: &viewProperties)
            (radio as? RadioView)?.update(with: viewProperties)
        }
        return radio
    }
    
    private func createButton(
        text: String,
        action: @escaping () -> Void,
        style: ButtonViewStyle?
    ) -> UIView? {
        var viewProperties = ButtonView.ViewProperties(attributedText: text.attributed)
        viewProperties.onTap = action
        
        let newStyle = style ?? ButtonViewStyle(
            size: .small,
            color: .accent,
            variant: .primary,
            state: .default,
            icon: .without
        )
        newStyle.update(viewProperties: &viewProperties)
        
        let button = RowBlocksService().createRowBlock(.atom(.button(viewProperties)))
        return button
    }
    
    private func createLabel(
        _ text: String,
        _ style: LabelViewStyle?
    ) -> UIView? {
        var viewProperties = LabelView.ViewProperties(text: text.attributed)
        
        let newStyle = style ?? LabelViewStyle(variant: .rowSubtitle)
        newStyle.update(viewProperties: &viewProperties)
        
        let label = RowBlocksService().createRowBlock(.atom(.label(viewProperties)))
        return label
    }
    
    private func createButtonIcon(
        _ image: UIImage,
        _ onTap: @escaping () -> Void,
        _ style: ButtonIconStyle?
    ) -> UIView? {
        var viewProperties = ButtonIcon.ViewProperties()
        viewProperties.image = image
        viewProperties.onTap = onTap
        
        let newStyle = style ?? ButtonIconStyle(
            variant: .primary,
            size: .small,
            state: .default,
            color: .accent
        )
        newStyle.update(viewProperties: &viewProperties)
        
        let buttonIcon = RowBlocksService().createRowBlock(.atom(.buttonIcon(viewProperties)))
        return buttonIcon
    }
    
    private func createTitleView(
        _ title: String,
        _ style: TitleViewStyle?
    ) -> UIView? {
        var viewProperties = TitleView.ViewProperties()
        viewProperties.title = .init(string: title)
        
        let newStyle = style ?? TitleViewStyle(size: .medium, color: .primary)
        newStyle.update(viewProperties: &viewProperties)
        
        let titleView = RowBlocksService().createRowBlock(.atom(.titleView(viewProperties)))
        return titleView
    }
}
