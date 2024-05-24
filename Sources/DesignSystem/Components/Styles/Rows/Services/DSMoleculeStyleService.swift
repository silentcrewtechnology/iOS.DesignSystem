import Components
import UIKit

public struct DSMoleculeStyleService {
    public init() { }
    
    public func createMolecule(_ dsMolecule: DSMoleculeElement) -> UIView? {
        switch dsMolecule {
        case .titleWithSubtitle(let title, let subtitle):
            return createTitleWithSubtitle(title, subtitle)
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
        }
    }
}

private extension DSMoleculeStyleService {
    private func createTitleWithSubtitle(
        _ title: (String, LabelViewStyle?),
        _ subtitle: (String, LabelViewStyle?),
        _ atomService: DSAtomStyleService = DSAtomStyleService()
    ) -> UIView? {
        let title = atomService.createAtom(.title(title.0, title.1))
        let subtitle = atomService.createAtom(.subtitle(subtitle.0, subtitle.1))
        
        return connect(top: title, bottom: subtitle)
    }
    
    private func createSubtitleWithTitle(
        _ subtitle: (String, LabelViewStyle?),
        _ title: (String, LabelViewStyle?),
        _ atomService: DSAtomStyleService = DSAtomStyleService()
    ) -> UIView? {
        let subtitle = atomService.createAtom(.subtitle(subtitle.0, subtitle.1))
        let title = atomService.createAtom(.title(title.0, title.1))
        
        return connect(top: subtitle, bottom: title)
    }
    
    private func createIcons20(
        _ icons: [(UIImage, ImageViewStyle?)],
        _ atomService: DSAtomStyleService = DSAtomStyleService()
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
        _ icon: (UIImage, ImageViewStyle?),
        _ atomService: DSAtomStyleService = DSAtomStyleService()
    ) -> UIView {
        let indexLabel = atomService.createAtom(.index(indexText.0, indexText.1))
        let icon = atomService.createAtom(.icon24(icon.0, icon.1))
        
        return connect(left: indexLabel, right: icon, spacing: 4)
    }
    
    private func createIndexWithIcons20(
        _ indexText: (String, LabelViewStyle?),
        _ icons: [(UIImage, ImageViewStyle?)],
        _ atomService: DSAtomStyleService = DSAtomStyleService()
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
        _ toggle: (Bool, (Bool) -> Void, ToggleViewStyle?),
        _ atomService: DSAtomStyleService = DSAtomStyleService()
    ) -> UIView {
        let indexLabel = atomService.createAtom(.index(indexText.0, indexText.1))
        let toggleView = atomService.createAtom(.toggle(toggle.0, toggle.1, toggle.2))
        
        return connect(left: indexLabel, right: toggleView)
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
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
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
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        rightView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalTo(leftView.snp.right).offset(spacing)
            make.right.equalToSuperview()
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
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                
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
}
