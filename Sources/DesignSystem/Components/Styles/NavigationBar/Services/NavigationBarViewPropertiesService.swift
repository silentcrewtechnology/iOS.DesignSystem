import UIKit
import Components

public final class NavigationBarViewPropertiesService {
    
    // MARK: - Private properties
    
    private var navigationBarStyle = NavigationBarStyle(variant: .none, color: .main)
    
    // MARK: - Life cycle
    
    public init() { }
    
    // MARK: - Methods
    
    public func createBasicVP(
        title: String? = nil,
        subtitle: String? = nil,
        margins: RowBaseContainer.ViewProperties.Margins? = nil,
        color: NavigationBarStyle.Color = .main,
        backAction: (() -> Void)? = nil
    ) -> NavigationBar.ViewProperties {
        var navigationBarVP = NavigationBar.ViewProperties()
        navigationBarStyle.update(
            viewProperties: &navigationBarVP,
            newVariant: .basic(
                title: title,
                subtitle: subtitle,
                margins: margins
            ),
            newColor: color,
            backAction: backAction
        )
        
        return navigationBarVP
    }
}
