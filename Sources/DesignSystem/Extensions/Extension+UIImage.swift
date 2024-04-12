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
    
    /// Текущая иконка по центру поверх иконки-фона
    func centered(
        in backgroundImage: UIImage
    ) -> UIImage {
        let backgroundSize = backgroundImage.size
        let renderer = UIGraphicsImageRenderer(size: backgroundSize)
        let centerAdjustedOrigin = CGPoint(
            x: (backgroundSize.width - size.width) / 2,
            y: (backgroundSize.height - size.height) / 2)
        let image = renderer.image { _ in
            backgroundImage.draw(at: .zero)
            draw(at: centerAdjustedOrigin)
        }
        return image
    }
    
    /// UIImage-круг с цветной заливкой
    static func circle(
        backgroundColor: UIColor,
        diameter: CGFloat
    ) -> UIImage {
        let size = CGSize(width: diameter, height: diameter)
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { _ in
            backgroundColor.setFill()
            UIBezierPath(ovalIn: .init(origin: .zero, size: size))
                .fill()
        }
        return image
    }
}
