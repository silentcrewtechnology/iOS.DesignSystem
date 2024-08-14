import UIKit
import Components

public enum AtomDSElement {
    case title(String, LabelViewStyle?)
    case subtitle(String, LabelViewStyle?)
    case index(String, LabelViewStyle?)
    case amountText(String, LabelViewStyle?)
    case copyText(String, LabelViewStyle?)
    case subindex(String, LabelViewStyle?)
    case image40(UIImage, ImageViewStyle?)
    case icon24(UIImage, ImageViewStyle?)
    case icon20(UIImage, ImageViewStyle?)
    case card(UIImage, CardImageViewStyle?)
    case toggle(Bool, (Bool) -> Void, ToggleViewStyle?)
    case checkbox(Bool, (Bool) -> Void, CheckboxViewStyle?)
    case radio(Bool, () -> Void, RadioViewStyle?)
    case button(String, () -> Void, ButtonViewStyle?)
    case buttonIcon(UIImage, () -> Void, ButtonIconStyle?)
    case titleView(String, TitleViewStyle?)
    
    // Элементы Дизайн Системы
    case badgeView(BadgeView.ViewProperties, BadgeStyle?)
    case inputView(InputView.ViewProperties, InputViewStyle?)
    case chipsView(ChipsView.ViewProperties, ChipsViewStyle?)
}

public enum DSMoleculeElement {
    case titleWithSubtitle((String, LabelViewStyle?), (String, LabelViewStyle?))
    case titleWithSubtitles((String, LabelViewStyle?), [(String, LabelViewStyle?)])
    case subtitleWithTitle((String, LabelViewStyle?), (String, LabelViewStyle?))
    case icons20([(UIImage, ImageViewStyle?)])
    case indexWithIcon24((String, LabelViewStyle?), (UIImage, ImageViewStyle?))
    case indexWithIcons20((String, LabelViewStyle?), [(UIImage, ImageViewStyle?)])
    case indexWithToggle((String, LabelViewStyle?), (Bool, (Bool) -> Void, ToggleViewStyle?))
    case buttonWithSubindex((String, () -> Void, ButtonViewStyle?), (String, LabelViewStyle?))
    case horizontalChipses([(ChipsView.ViewProperties, ChipsViewStyle?)])
}

public enum DSRowBlocks {
    case atom(AtomDSElement)
    case molecule(DSMoleculeElement)
}
