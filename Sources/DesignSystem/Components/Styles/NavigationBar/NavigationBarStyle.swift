//
//  NavigationBarStyle.swift
//  
//
//  Created by user on 22.07.2024.
//

import UIKit
import Components
import Extensions
import Colors

public final class NavigationBarStyle {
    
    // MARK: - Properties
    
    public enum Variant {
        case basic(
            title: String?,
            subtitle: String?,
            margins: RowBaseContainer.ViewProperties.Margins?
        )
        case collapsed(title: String?)
        case mainScreen(
            name: String,
            margins: RowBaseContainer.ViewProperties.Margins?,
            onProfile: () -> Void
        )
        case basicAmount(
            title: String?,
            subtitle: String?,
            spacing: CGFloat?,
            updateAction: (() -> Void)?
        )
        case search(updater: UISearchResultsUpdating?)
        case none
    }
    
    public enum Color {
        case main
        case primary
    }
    
    // MARK: - Private properties
    
    private let variant: Variant
    private let color: Color
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
        backAction: (() -> Void)? = nil
    ) {
        self.backAction = backAction
        
        let backButton = UIBarButtonItem(
            image: .ic24ArrowLeft
                .withTintColor(.Semantic.LightTheme.Content.Base.primary)
                .withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(backTapped)
        )
        viewProperties.leftBarButtonItems = [backButton]
        viewProperties.largeTitleDisplayMode = .never
        
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
        case let .mainScreen(name, margins, onProfile):
            let profileView = createProfileView(name: name, margins: margins)
            profileView.addTapGesture(onProfile)
            
            viewProperties.leftBarButtonItems = [.init(customView: profileView)]
        case let .basicAmount(title, subtitle, spacing, updateAction):
            viewProperties.titleView = createBasicAmountTitleView(
                title: title,
                subtitle: subtitle,
                spacing: spacing,
                updateAction: updateAction
            )
        case .search(let updater):
            viewProperties.searchController = createSearchController(updater: updater)
            viewProperties.hidesSearchBarWhenScrolling = false
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
                (subtitle ?? "", .init(variant: .rowSubtitle, alignment: .center))
            )
        )
        
        if title == nil {
            centerView = .atom(.subtitle(subtitle ?? "", .init(variant: .rowSubtitle, alignment: .center)))
        } else if subtitle == nil {
            centerView = .atom(.title(title ?? "", .init(variant: .rowAmount, alignment: .center), nil))
        }
        
        return DSCreationRowsViewService().createViewRowWithBlocks(
            center: centerView,
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
        margins: RowBaseContainer.ViewProperties.Margins? = nil
    ) -> UIView {
        return DSCreationRowsViewService().createViewRowWithBlocks(
            leading: .atom(
                .image40(
                    .ic24User
                        .withTintColor(.Semantic.LightTheme.Content.Base.primary)
                        .centered(in: .circle(
                            backgroundColor: .white,
                            diameter: 40))
                        .withRenderingMode(.alwaysOriginal),
                    nil)),
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
        let subtitleStyle = LabelViewStyle(variant: .rowSubtitle, alignment: .center)
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
    
    private func createSearchController(updater: UISearchResultsUpdating?) -> UISearchController {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = updater
        searchController.hidesNavigationBarDuringPresentation = true
        let barButtonAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Semantic.LightTheme.Content.Accent.hover,
            .font: UIFont.textM
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
            .setTitleTextAttributes(barButtonAttributes, for: .normal)
        
        let textFieldAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Semantic.LightTheme.Content.Base.primary,
            .font: UIFont.textM
        ]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
            .defaultTextAttributes = textFieldAttributes
        
        return searchController
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
