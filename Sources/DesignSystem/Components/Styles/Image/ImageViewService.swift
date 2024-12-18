//
//  ImageViewService.swift
//
//
//  Created by user on 18.09.2024.
//

import UIKit
import Components

public protocol ImageViewServiceProtocol {
    var view: ImageView { get }
    var viewProperties: ImageView.ViewProperties { get }
    var style: ImageViewStyle { get }
}

public final class ImageViewService: ImageViewServiceProtocol {
    
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
    
    // MARK: - UpdateParameters
    public struct ImageUpdateParameters {
        public var newType: ImageViewStyle.Types?
        public var newColor: ImageViewStyle.Color?
        
        public init(
            newType: ImageViewStyle.Types? = nil,
            newColor: ImageViewStyle.Color? = nil
        ) {
            self.newType = newType
            self.newColor = newColor
        }
    }
    
    // MARK: - Methods
    public func update(
        with parameters: ImageUpdateParameters? = nil
    ) {
        style.update(
            type: parameters?.newType,
            color: parameters?.newColor,
            viewProperties: &viewProperties
        )
        view.update(with: viewProperties)
    }
}
extension ImageViewService {
    @available(*, deprecated, message: "Use  update(with parameters:")
    public func update(
        newType: ImageViewStyle.Types? = nil,
        newColor: ImageViewStyle.Color? = nil
    ) {
        update(with: .init(
            newType: newType,
            newColor: newColor
        ))
    }
}
