//
//  ImagesService.swift
//  
//
//  Created by firdavs on 13.06.2023.
//

import ImagesService
import UIKit

public extension UIImage {
    
    /// Возвращает цветную иконку (сама иконка выступает в качестве маски)
    @available(iOS, deprecated: 13.0, message: "Use withTintColor(_ color: UIColor) instead.")
    @objc func tinted(with color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { _ in
            color.set()
            withRenderingMode(.alwaysTemplate)
                .draw(at: .zero)
        }
        return image
    }
}
