import Foundation

public enum StepperItemViewStyle {
    
    public enum Variant {
        case active
        case disabled
    }
    
    public static func reactivate(
        variant: Variant,
        viewProperties: StepperItemView.ViewProperties
    ) -> StepperItemView.ViewProperties {
        var viewProperties = viewProperties
        switch variant {
        case .active:
            viewProperties.backgroundColor = .contentAction
        case .disabled:
            viewProperties.backgroundColor = .backgroundSecondary
        }
        return viewProperties
    }
}
