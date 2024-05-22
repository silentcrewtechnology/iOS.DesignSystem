import UIKit
import Components
import Colors
import ImagesService

public struct CardImageViewStyle {
    
    public enum PaymentSystem {
        case Visa
        case Mastercard
        case Maestro
        case Mir
        case none
    }
    
    private let paymentSystem: PaymentSystem
    private let backgroundImage: UIImage
    
    public init(
        paymentSystem: PaymentSystem,
        backgroundImage: UIImage
    ) {
        self.paymentSystem = paymentSystem
        self.backgroundImage = backgroundImage
    }
    
    public func update(
        viewProperties: inout CardImageView.ViewProperties
    ) {
        viewProperties.backgroundImage = backgroundImage
        viewProperties.paymentSystemImage = paymentSystem.image()
    }
}

public extension CardImageViewStyle.PaymentSystem {
    
    func image() -> UIImage? {
        switch self {
        case .Visa:
                .ic24CardVisaLight
        case .Mastercard:
                .ic24CardMastercardLight
        case .Maestro:
                .ic24CardMaestroLight
        case .Mir:
                .ic24CardMirLight
        case .none:
                .ic24CardUnknownLight
        }
    }
}
