import UIKit

public enum AtomDSElement {
    case title(String, LabelViewStyle?)
    case subtitle(String, LabelViewStyle?)
    case image40(UIImage, ImageViewStyle?)
    case card(UIImage, CardImageViewStyle?)
    case index(String, LabelViewStyle?)
    case icon24(UIImage, ImageViewStyle?)
    case icon20(UIImage, ImageViewStyle?)
    case toggle(Bool, (Bool) -> Void, ToggleViewStyle?)
    case amountText(String, LabelViewStyle?)
    case checkbox(Bool, (Bool) -> Void, CheckboxViewStyle?)
    case radio(Bool, () -> Void, RadioViewStyle?)
    case button(String, () -> Void, ButtonViewStyle?)
    case copyText(String, LabelViewStyle?)
}

public enum DSMoleculeElement {
    case titleWithSubtitle((String, LabelViewStyle?), (String, LabelViewStyle?))
    case subtitleWithTitle((String, LabelViewStyle?), (String, LabelViewStyle?))
    case icons20([(UIImage, ImageViewStyle?)])
    case indexWithcIcon24((String, LabelViewStyle?), (UIImage, ImageViewStyle?))
    case indexWithIcons20((String, LabelViewStyle?), [(UIImage, ImageViewStyle?)])
    case indexWithToggle((String, LabelViewStyle?), (Bool, (Bool) -> Void, ToggleViewStyle?))
}

public enum DSRowBlocks {
    case atom(AtomDSElement)
    case molecule(DSMoleculeElement)
}
