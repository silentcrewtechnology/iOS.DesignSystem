import Components
import UIKit

public struct DSMoleculeStyleService {
    
    // MARK: - Private properties
    
    private let atomService = DSAtomStyleService()
    private let connectionService = ViewsConnectionService()
    
    // MARK: - Life cycle
    
    public init() { }
    
    // MARK: - Methods
    
    public func createMolecule(_ dsMolecule: DSMoleculeElement) -> UIView? {
        switch dsMolecule {
        case .titleWithSubtitle(let title, let subtitle):
            return createTitleWithSubtitle(title, subtitle)
        case .titleWithSubtitles(let title, let subtitles):
            return createTitleWithSubtitles(title, subtitles)
        case .subtitleWithTitle(let subtitle, let title):
            return createSubtitleWithTitle(subtitle, title)
        case .icons20(let icons):
            return createIcons20(icons)
        case .indexWithIcon24(let index, let icon):
            return createIndexWithIcon24(index, icon)
        case .indexWithIcons20(let index, let icons):
            return createIndexWithIcons20(index, icons)
        case .indexWithToggle(let index, let style):
            return createIndexWithToggle(index, style)
        case .buttonWithSubtitle(let button, let subindex):
            return createButtonWithSubtitle(button, subindex)
        case .horizontalChipsViews(let chipsViews):
            return createHorizontalChips(views: chipsViews)
        }
    }
}

// MARK: - Creation

private extension DSMoleculeStyleService {
    private func createTitleWithSubtitle(
        _ title: (String, LabelViewStyle?, UILongPressGestureRecognizer?),
        _ subtitle: (String, LabelViewStyle?)
    ) -> UIView? {
        guard let title = atomService.createAtom(.title(title.0, title.1, title.2)),
              let subtitle = atomService.createAtom(.subtitle(subtitle.0, subtitle.1))
        else { return nil }
        
        return connectionService.connect(topView: title, bottomView: subtitle)
    }
    
    private func createSubtitleWithTitle(
        _ subtitle: (String, LabelViewStyle?),
        _ title: (String, LabelViewStyle?, UILongPressGestureRecognizer?)
    ) -> UIView? {
        guard let subtitle = atomService.createAtom(.subtitle(subtitle.0, subtitle.1)),
              let title = atomService.createAtom(.title(title.0, title.1, title.2))
        else { return nil }
        
        return connectionService.connect(topView: subtitle, bottomView: title)
    }
    
    private func createIcons20(
        _ icons: [(UIImage, ImageViewStyle?)]
    ) -> UIView {
        var atomsFromIcons: [UIView] = []
        
        for (index, icon) in icons.enumerated() {
            if let iconAtom = atomService.createAtom(.icon20(icon.0, icon.1)) {
                iconAtom.accessibilityIdentifier = "\(String(describing: iconAtom.accessibilityIdentifier ?? ""))_\(String(describing: index))"
                atomsFromIcons.append(iconAtom)
            }
        }
        
        return connectionService.connect(horizontalyViews: atomsFromIcons)
    }
    
    private func createIndexWithIcon24(
        _ indexText: (String, LabelViewStyle?),
        _ icon: (UIImage, ImageViewStyle?)
    ) -> UIView {
        guard let indexLabel = atomService.createAtom(.index(indexText.0, indexText.1)),
              let icon = atomService.createAtom(.icon24(icon.0, icon.1))
        else { return UIView() }
        
        return connectionService.connect(leftView: indexLabel, rightView: icon, spacing: 4)
    }
    
    private func createIndexWithIcons20(
        _ indexText: (String, LabelViewStyle?),
        _ icons: [(UIImage, ImageViewStyle?)]
    ) -> UIView {
        guard let indexLabel = atomService.createAtom(.index(indexText.0, indexText.1))
        else { return UIView() }
        
        var atomsFromIcons: [UIView] = []
        for (index, icon) in icons.enumerated() {
            if let iconAtom = atomService.createAtom(.icon20(icon.0, icon.1)) {
                iconAtom.accessibilityIdentifier = "\(String(describing: iconAtom.accessibilityIdentifier ?? ""))_\(String(describing: index))"
                atomsFromIcons.append(iconAtom)
            }
        }
        let iconsResult = connectionService.connect(horizontalyViews: atomsFromIcons)
        
        return connectionService.connect(topView: indexLabel, bottomView: iconsResult)
    }
    
    private func createIndexWithToggle(
        _ indexText: (String, LabelViewStyle?),
        _ toggle: (Bool, (Bool) -> Void, ToggleViewStyle?)
    ) -> UIView {
        guard let indexLabel = atomService.createAtom(.index(indexText.0, indexText.1)),
              let toggleView = atomService.createAtom(.toggle(toggle.0, toggle.1, toggle.2))
        else { return UIView() }
        
        return connectionService.connect(leftView: indexLabel, rightView: toggleView)
    }
    
    private func createButtonWithSubtitle(
        _ button: (String, () -> Void, ButtonViewStyle?),
        _ subtileText: (String, LabelViewStyle?)
    ) -> UIView {
        guard let buttonView = atomService.createAtom(.button(button.0, button.1, button.2)),
              let subtitleLabel = atomService.createAtom(.subtitle(subtileText.0, subtileText.1))
        else { return UIView() }
        
        return connectionService.connect(topView: buttonView, bottomView: subtitleLabel)
    }
    
    private func createTitleWithSubtitles(
        _ titleText: (String, LabelViewStyle?, UILongPressGestureRecognizer?),
        _ subtitlesText: [(String, LabelViewStyle?)]
    ) -> UIView {
        guard let titleLabel = atomService.createAtom(.title(titleText.0, titleText.1, titleText.2)) else { return UIView() }
        
        var atomsFromSubtitles: [UIView] = []
        for (index, subtitle) in subtitlesText.enumerated() {
            if let subtitleText = atomService.createAtom(.subtitle(subtitle.0, subtitle.1)) {
                subtitleText.accessibilityIdentifier = "\(String(describing: subtitleText.accessibilityIdentifier ?? ""))_\(String(describing: index))"
                atomsFromSubtitles.append(subtitleText)
            }
        }
        let subtitlesResult = connectionService.connect(verticalyViews: atomsFromSubtitles)
        
        return connectionService.connect(topView: titleLabel, bottomView: subtitlesResult)
    }
}

// MARK: - Creation

private extension DSMoleculeStyleService {
    private func createHorizontalChips(
        views: [ChipsView]
    ) -> UIView {
        
        var atomsFromChips: [UIView] = []
        for (index, view) in views.enumerated() {
            view.accessibilityIdentifier = "\(String(describing: view.accessibilityIdentifier ?? ""))_\(String(describing: index))"
            atomsFromChips.append(view)
        }
        return connectionService.connectOnScroll(horizontalyViews: atomsFromChips, spacing: 6)
    }
}

