import UIKit
import Components
import Colors
import ImagesService

public struct ButtonPayStyle {
    
    // MARK: - Properties
    
    public enum `Type` {
        case samsung
        case sbp
        case google
        case apple
        case yandex
        
        func logoImage() -> UIImage {
            switch self {
            case .samsung: return .brand28SamsungPayMainInverse
            case .sbp: return .brand28SBPMainInverse
            case .google: return .brand28GooglePayMainInverse
            case .apple: return .brand28ApplePayMainInverse
            case .yandex: return .brand28YandexPayMainInverse
            }
        }
    }
    
    // MARK: - Private properties
    
    private var type: Type
    
    // MARK: - Life cycle
    
    public init(type: Type) {
        self.type = type
    }
    
    public func update(viewProperties: inout ButtonPay.ViewProperties) {
        viewProperties.backgroundColor = .Components.ButtonPay.Background.Color.color
        viewProperties.image = type.logoImage()
        viewProperties.height = 56
        viewProperties.maxWidth = 257
        viewProperties.cornerRadius = 8
        viewProperties.horizontalStackSpacing = 8
        viewProperties.stackViewInsets = .init(top: .zero, left: 16, bottom: .zero, right: 16)
        viewProperties.text = .init(string: "Добавить в")
            .fontStyle(.textM)
            .foregroundColor(.Components.ButtonPay.Label.Color.color)
    }
}
