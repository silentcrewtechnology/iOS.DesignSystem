import UIKit
import Components
import Extensions
import Colors

public final class NavigationBarStyle {
    
    // MARK: - Properties
    
    public enum Variant {
        case basic(
            title: String? = nil,
            subtitle: String? = nil,
            margins: RowBaseContainer.ViewProperties.Margins? = nil
        )
        case collapsed(title: String? = nil)
        case mainScreen(
            name: String,
            icon: UIImage,
            margins: RowBaseContainer.ViewProperties.Margins? = nil,
            onProfile: () -> Void
        )
        case basicAmount(
            title: String? = nil,
            subtitle: String? = nil,
            spacing: CGFloat? = nil,
            updateAction: (() -> Void)? = nil
        )
        case search(
            title: String? = nil,
            subtitle: String? = nil,
            margins: RowBaseContainer.ViewProperties.Margins? = nil,
            onTextDidChange: ((String) -> Void)? = nil,
            cancelButtonClicked: (() -> Void)? = nil,
            textDidBeginEditing: (() -> Void)? = nil,
            textDidEndEditing: (() -> Void)? = nil
        )
        case customLeftView(
            leading: DSRowBlocks? = nil,
            center: DSRowBlocks? = nil,
            trailing: DSRowBlocks? = nil,
            margins: RowBaseContainer.ViewProperties.Margins? = nil
        )
        case none
    }
    
    public enum Color {
        case main
        case primary
    }
    
    // MARK: - Private properties
    
    private var variant: Variant
    private var color: Color
    private var backAction: (() -> Void)?
    private var updateAction: (() -> Void)?
    
    // MARK: - Life cycle
    
    public init(variant: Variant, color: Color) {
        self.variant = variant
        self.color = color
    }
    
    // MARK: - Methods
    
    public func update(
        viewProperties: inout NavigationBar.ViewProperties,
        newVariant: Variant? = nil,
        newColor: Color? = nil,
        backAction: (() -> Void)? = nil
    ) {
        self.backAction = backAction
        
        if let newVariant {
            variant = newVariant
        }
        
        if let newColor {
            color = newColor
        }
        
        let rightBarButtonItems = viewProperties.rightBarButtonItems
        viewProperties = .init()
        viewProperties.rightBarButtonItems = rightBarButtonItems
        
        if self.backAction != nil {
            let backButton = UIBarButtonItem(
                image: .ic24ArrowLeft
                    .withTintColor(.Semantic.LightTheme.Content.Base.primary)
                    .withRenderingMode(.alwaysOriginal),
                style: .plain,
                target: self,
                action: #selector(backTapped)
            )
            viewProperties.leftBarButtonItems = [backButton]
        } else {
            viewProperties.leftBarButtonItems = nil
        }
        
        let otherBarAppearance = UINavigationBarAppearance()
        otherBarAppearance.backgroundColor = backgroundColor(color: color)
        otherBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.Semantic.LightTheme.Content.Base.primary,
            .font: UIFont.textM_1
        ]
        otherBarAppearance.shadowColor = .clear
        
        let standartBarAppearance = UINavigationBarAppearance()
        standartBarAppearance.backgroundColor = backgroundColor(color: color)
        standartBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.Semantic.LightTheme.Content.Base.primary,
            .font: UIFont.textM_1
        ]
        
        viewProperties.largeTitleDisplayMode = .never
        viewProperties.isNavigationBarHidden = false
        switch variant {
        case let .basic(title, subtitle, margins):
            viewProperties.titleView = createBasicTitleView(
                title: title,
                subtitle: subtitle,
                margins: margins
            )
        case .collapsed(let title):
            standartBarAppearance.configureWithOpaqueBackground()
            standartBarAppearance.backgroundColor = backgroundColor(color: color)
            standartBarAppearance.largeTitleTextAttributes = [
                .foregroundColor: UIColor.Semantic.LightTheme.Content.Base.primary,
                .font: UIFont.text2XL_1
            ]
            
            viewProperties.title = title
            viewProperties.largeTitleDisplayMode = .always
            viewProperties.prefersLargeTitles = true
        case let .mainScreen(name, icon, margins, onProfile):
            let profileView = createProfileView(name: name, icon: icon, margins: margins)
            profileView.addTapGesture(onProfile)
            viewProperties.leftBarButtonItems = [.init(customView: profileView)]
        case let .basicAmount(title, subtitle, spacing, updateAction):
            viewProperties.titleView = createBasicAmountTitleView(
                title: title,
                subtitle: subtitle,
                spacing: spacing,
                updateAction: updateAction
            )
        case let .search(
            title,
            subtitle,
            margins,
            onTextDidChange,
            cancelButtonClicked,
            textDidBeginEditing,
            textDidEndEditing
        ):
            viewProperties.titleView = createBasicTitleView(
                title: title,
                subtitle: subtitle,
                margins: margins
            )
            viewProperties.searchController = createSearchController(
                onTextDidChange: onTextDidChange,
                cancelButtonClicked: cancelButtonClicked,
                textDidBeginEditing: textDidBeginEditing,
                textDidEndEditing: textDidEndEditing
            )
            viewProperties.hidesSearchBarWhenScrolling = false
        case let .customLeftView(leading, center, trailing, margins):
            let customLeftView = DSCreationRowsViewService().createViewRowWithBlocks(
                leading: leading,
                center: center,
                trailing: trailing,
                margins: margins
            )
            viewProperties.leftBarButtonItems = [.init(customView: customLeftView)]
        case .none:
            viewProperties.isNavigationBarHidden = true
        }
        
        viewProperties.standartAppearance = standartBarAppearance
        viewProperties.scrollEdgeAppearance = otherBarAppearance
        viewProperties.compactAppearance = otherBarAppearance
    }
    
    // MARK: - Private methods
    
    private func createBasicTitleView(
        title: String?,
        subtitle: String?,
        margins: RowBaseContainer.ViewProperties.Margins? = nil
    ) -> UIView {
        var centerView: DSRowBlocks = .molecule(
            .titleWithSubtitle(
                (title ?? "", .init(variant: .rowAmount, alignment: .center), nil),
                (subtitle ?? "", .init(variant: .rowCustomSubtitle(customColor: nil), alignment: .center))
            )
        )
        
        if title == nil {
            centerView = .atom(.subtitle(subtitle ?? "", .init(
                variant: .rowCustomSubtitle(customColor: nil),
                alignment: .center
            )))
        } else if subtitle == nil {
            centerView = .atom(.title(title ?? "", .init(variant: .rowAmount, alignment: .center), nil))
        }
        
        return DSCreationRowsViewService().createViewRowWithBlocks(
            center: centerView,
            centralBlockAlignment: .center,
            margins: margins ?? .init(
                leading: 16,
                trailing: 16,
                top: .zero,
                bottom: .zero,
                spacing: 16
            )
        )
    }
    
    private func createProfileView(
        name: String,
        icon: UIImage,
        margins: RowBaseContainer.ViewProperties.Margins? = nil
    ) -> UIView {
        return DSCreationRowsViewService().createViewRowWithBlocks(
            leading: .atom(.image40(icon, .init(type: .fillImage(icon), color: .main))),
            center: .molecule(
                .indexWithIcon24(
                    (name, .init(variant: .rowAmount, alignment: .left)),
                    (.ic24ChevronSmallRight
                        .withTintColor(.Semantic.LightTheme.Content.Base.primary)
                        .withRenderingMode(.alwaysOriginal),
                     nil)
                )),
            margins: margins ?? .init(
                leading: .zero,
                trailing: 16,
                top: 2,
                bottom: 2,
                spacing: 16
            )
        )
    }
    
    private func createBasicAmountTitleView(
        title: String?,
        subtitle: String?,
        spacing: CGFloat?,
        updateAction: (() -> Void)?
    ) -> UIView {
        self.updateAction = updateAction
        
        var titleVP = LabelView.ViewProperties(text: .init(string: title ?? ""))
        let titleStyle = LabelViewStyle(variant: .rowAmount, alignment: .center)
        titleStyle.update(viewProperties: &titleVP)
        let titleLabel = LabelView()
        titleLabel.update(with: titleVP)
        
        let updateButton = UIButton()
        updateButton.setImage(.ic16Reload.withTintColor(.Semantic.LightTheme.Content.Accent.hover), for: .normal)
        updateButton.addTarget(self, action: #selector(updateTapped), for: .touchUpInside)
        
        let horizontalStackView = UIStackView(arrangedSubviews: [titleLabel, updateButton])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = spacing ?? 8
        
        if subtitle == nil {
            return horizontalStackView
        }
        
        var subtitleVP = LabelView.ViewProperties(text: .init(string: subtitle ?? ""))
        let subtitleStyle = LabelViewStyle(
            variant: .rowCustomSubtitle(customColor: nil),
            alignment: .center
        )
        subtitleStyle.update(viewProperties: &subtitleVP)
        let subtitleLabel = LabelView()
        subtitleLabel.update(with: subtitleVP)
        
        if title == nil {
            return subtitleLabel
        }
        
        let verticalStackView = UIStackView(arrangedSubviews: [subtitleLabel, horizontalStackView])
        verticalStackView.axis = .vertical
        
        return verticalStackView
    }
    
    private func createSearchController(
        onTextDidChange: ((String) -> Void)?,
        cancelButtonClicked: (() -> Void)?,
        textDidBeginEditing: (() -> Void)?,
        textDidEndEditing: (() -> Void)?
    ) -> UISearchController {
        let searchControllerService = InputSearchViewControllerService()
        searchControllerService.inputSearchService.update(
            newPlaceholder: .init(string: "Поиск"),
            newTextDidChange: onTextDidChange,
            newCancelButtonClicked: cancelButtonClicked,
            newTextDidBeginEditing: {
                searchControllerService.inputSearchService.update(newState: .active)
                textDidBeginEditing?()
            },
            newTextDidEndEditing: {
                searchControllerService.inputSearchService.update(newState: .default)
                textDidEndEditing?()
            }
        )

        return searchControllerService.view
    }
    
    private func backgroundColor(color: Color) -> UIColor {
        return color == .main
            ? .Semantic.LightTheme.Background.Surface.main
            : .Semantic.LightTheme.Background.Surface.primary
    }
    
    @objc private func backTapped() {
        backAction?()
    }
    
    @objc private func updateTapped() {
        updateAction?()
    }
}
