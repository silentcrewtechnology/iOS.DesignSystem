
import UIKit

public struct FontService {
    
    public static func registerFonts() {
        FontName.SFProDisplay.allCases.forEach {
            registerFont(bundle: .module, fontName: $0.rawValue)
        }
        
        FontName.Roboto.allCases.forEach {
            registerFont(bundle: .module, fontName: $0.rawValue)
        }
    }
    
    private static func registerFont(bundle: Bundle = Bundle.module, fontName: String, fontExtension: FontExtension = .ttf) {
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension.rawValue),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }
        
        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}
