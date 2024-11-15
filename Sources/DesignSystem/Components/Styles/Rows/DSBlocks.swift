import UIKit
import Components

public enum AtomDSElement {
    case title(String, LabelViewStyle?, UILongPressGestureRecognizer?)
    case subtitle(String, LabelViewStyle?)
    case index(String, LabelViewStyle?)
    case amountText(String, LabelViewStyle?)
    case label(String, LabelViewStyle?)
    case image40(UIImage, ImageViewStyle?)
    case icon24(UIImage, ImageViewStyle?)
    case icon20(UIImage, ImageViewStyle?)
    @available(*, deprecated, message: "Use cardWithMaskedNumber")
    case card(UIImage?, CardViewStyle?)
    case toggle(Bool, (Bool) -> Void, ToggleViewStyle?)
    case checkbox(Bool, (Bool) -> Void, CheckboxViewStyle?)
    case radio(Bool, () -> Void, RadioViewStyle?)
    case button(String, () -> Void, ButtonViewStyle?)
    case buttonIcon(UIImage, () -> Void, ButtonIconStyle?)
    case titleView(String, TitleViewStyle?)
    case cardWithMaskedNumber(UIImage?, NSMutableAttributedString?, CardViewStyle?)
    
    // Элементы Дизайн Системы
    case inputView(InputView.ViewProperties, InputViewStyle?)
    
    // Элементы Дизайн Системы with Updaters
    case view(UIView)
}

public enum DSMoleculeElement {
    case titleWithSubtitle((String, LabelViewStyle?, UILongPressGestureRecognizer?), (String, LabelViewStyle?))
    case titleWithSubtitles((String, LabelViewStyle?, UILongPressGestureRecognizer?), [(String, LabelViewStyle?)])
    case subtitleWithTitle((String, LabelViewStyle?), (String, LabelViewStyle?, UILongPressGestureRecognizer?))
    case icons20([(UIImage, ImageViewStyle?)])
    case indexWithIcon24((String, LabelViewStyle?), (UIImage, ImageViewStyle?))
    case indexWithIcons20((String, LabelViewStyle?), [(UIImage, ImageViewStyle?)])
    case indexWithToggle((String, LabelViewStyle?), (Bool, (Bool) -> Void, ToggleViewStyle?))
    case buttonWithSubtitle((String, () -> Void, ButtonViewStyle?), (String, LabelViewStyle?))
    
    // Элементы Дизайн Системы
    case horizontalChipsViews([ChipsView])
}

public enum DSRowBlocks {
    case atom(AtomDSElement)
    case molecule(DSMoleculeElement)
}
