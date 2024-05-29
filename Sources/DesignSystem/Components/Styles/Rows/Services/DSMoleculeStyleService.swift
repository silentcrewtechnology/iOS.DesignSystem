import Components
import UIKit

public struct DSMoleculeStyleService {
    
    // MARK: - Private properties
    
    private let atomService = DSAtomStyleService()
    
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
        case .buttonWithSubindex(let button, let subindex):
            return createButtonWithSubindex(button, subindex)
        }
    }
}

private extension DSMoleculeStyleService {
    private func createTitleWithSubtitle(
        _ title: (String, LabelViewStyle?),
        _ subtitle: (String, LabelViewStyle?)
    ) -> UIView? {
        let title = atomService.createAtom(.title(title.0, title.1))
        let subtitle = atomService.createAtom(.subtitle(subtitle.0, subtitle.1))
        
        return connect(top: title, bottom: subtitle)
    }
    
    private func createSubtitleWithTitle(
        _ subtitle: (String, LabelViewStyle?),
        _ title: (String, LabelViewStyle?)
    ) -> UIView? {
        let subtitle = atomService.createAtom(.subtitle(subtitle.0, subtitle.1))
        let title = atomService.createAtom(.title(title.0, title.1))
        
        return connect(top: subtitle, bottom: title)
    }
    
    private func createIcons20(
        _ icons: [(UIImage, ImageViewStyle?)]
    ) -> UIView {
        var atomsFromIcons: [UIView] = []
        
        for icon in icons {
            if let iconAtom = atomService.createAtom(.icon20(icon.0, icon.1)) {
                atomsFromIcons.append(iconAtom)
            }
        }
        
        return connect(horizontalyViews: atomsFromIcons)
    }
    
    private func createIndexWithIcon24(
        _ indexText: (String, LabelViewStyle?),
        _ icon: (UIImage, ImageViewStyle?)
    ) -> UIView {
        let indexLabel = atomService.createAtom(.index(indexText.0, indexText.1))
        let icon = atomService.createAtom(.icon24(icon.0, icon.1))
        
        return connect(left: indexLabel, right: icon, spacing: 4)
    }
    
    private func createIndexWithIcons20(
        _ indexText: (String, LabelViewStyle?),
        _ icons: [(UIImage, ImageViewStyle?)]
    ) -> UIView {
        let indexLabel = atomService.createAtom(.index(indexText.0, indexText.1))
        
        var atomsFromIcons: [UIView] = []
        for icon in icons {
            if let iconAtom = atomService.createAtom(.icon20(icon.0, icon.1)) {
                atomsFromIcons.append(iconAtom)
            }
        }
        let iconsResult = connect(horizontalyViews: atomsFromIcons)
        
        return connect(top: indexLabel, bottom: iconsResult)
    }
    
    private func createIndexWithToggle(
        _ indexText: (String, LabelViewStyle?),
        _ toggle: (Bool, (Bool) -> Void, ToggleViewStyle?)
    ) -> UIView {
        let indexLabel = atomService.createAtom(.index(indexText.0, indexText.1))
        let toggleView = atomService.createAtom(.toggle(toggle.0, toggle.1, toggle.2))
        
        return connect(left: indexLabel, right: toggleView)
    }
    
    private func createButtonWithSubindex(
        _ button: (String, () -> Void, ButtonViewStyle?),
        _ subindexText: (String, LabelViewStyle?)
    ) -> UIView {
        let buttonView = atomService.createAtom(.button(button.0, button.1, button.2))
        let subindexLabel = atomService.createAtom(.subindex(subindexText.0, subindexText.1))
        
        return connect(top: buttonView, bottom: subindexLabel)
    }
    
    private func createTitleWithSubtitles(
        _ titleText: (String, LabelViewStyle?),
        _ subtitlesText: [(String, LabelViewStyle?)]
    ) -> UIView {
        let titleLabel = atomService.createAtom(.title(titleText.0, titleText.1))
        
        var atomsFromSubtitles: [UIView] = []
        for subtitle in subtitlesText {
            if let subtitleText = atomService.createAtom(.subtitle(subtitle.0, subtitle.1)) {
                atomsFromSubtitles.append(subtitleText)
            }
        }
        let subtitlesResult = connect(verticalyViews: atomsFromSubtitles)
        
        return connect(top: titleLabel, bottom: subtitlesResult)
    }
}


private extension DSMoleculeStyleService {
    private func connect(top: UIView?, bottom: UIView?) -> UIView {
        let containerView = UIView()
        
        guard let topView = top, let bottomView = bottom else {
            return containerView
        }
        
        containerView.addSubview(topView)
        containerView.addSubview(bottomView)
        
        topView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        return containerView
    }
    
    private func connect(left: UIView?, right: UIView?, spacing: Int = 0) -> UIView {
        let containerView = UIView()
        
        guard let leftView = left, let rightView = right else {
            return containerView
        }
        
        containerView.addSubview(leftView)
        containerView.addSubview(rightView)
        
        leftView.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview()
        }
        
        rightView.snp.makeConstraints { make in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(leftView.snp.right).offset(spacing)
        }
        
        return containerView
    }
    
    private func connect(horizontalyViews: [UIView]) -> UIView {
        let containerView = UIView()
        
        guard !horizontalyViews.isEmpty else {
            return containerView
        }
        
        for (index, view) in horizontalyViews.enumerated() {
            containerView.addSubview(view)

            view.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                
                if index == 0 {
                    make.left.equalToSuperview()
                } else {
                    make.left.equalTo(horizontalyViews[index - 1].snp.right)
                }
                
                if index == horizontalyViews.count - 1 {
                    make.right.equalToSuperview()
                }
            }
        }
        
        return containerView
    }
    
    private func connect(verticalyViews: [UIView]) -> UIView {
        let containerView = UIView()
        
        guard !verticalyViews.isEmpty else {
            return containerView
        }
        
        for (index, view) in verticalyViews.enumerated() {
            containerView.addSubview(view)
            
            view.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                
                if index == 0 {
                    make.top.equalToSuperview()
                } else {
                    make.top.equalTo(verticalyViews[index - 1].snp.bottom)
                }
                
                if index == verticalyViews.count - 1 {
                    make.bottom.equalToSuperview()
                }
            }
        }
        
        return containerView
    }
}
