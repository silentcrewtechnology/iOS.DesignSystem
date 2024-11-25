//
//  ImageViewService.swift
//
//
//  Created by user on 18.09.2024.
//

import UIKit
import Components

public final class ImageViewService {
    
    // MARK: - Properties
    
    public private(set) var view: ImageView
    public private(set) var viewProperties: ImageView.ViewProperties
    public private(set) var style: ImageViewStyle
    
    // MARK: - Life cycle
    
    public init(
        view: ImageView = .init(),
        viewProperties: ImageView.ViewProperties = .init(),
        style: ImageViewStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        
        update()
    }
    
    // MARK: - Methods
    
    public func update(
        newType: ImageViewStyle.Types? = nil,
        newColor: ImageViewStyle.Color? = nil,
        newSize: ImageViewStyle.Size? = nil,
        newImage: UIImage? = nil
    ) {
        if let newImage {
            viewProperties.image = newImage
        }
        
        style.update(
            type: newType,
            color: newColor,
            size: newSize,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
}
