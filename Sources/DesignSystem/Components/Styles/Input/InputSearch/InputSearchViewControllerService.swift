//
//  InputSearchViewControllerService.swift
//  DesignSystem
//
//  Created by user on 08.11.2024.
//

import Components
import UIKit

public final class InputSearchViewControllerService {
    
    // MARK: - Properties
    
    public private(set) var view: InputSearchViewController
    public private(set) var viewProperties: InputSearchViewController.ViewProperties
    public private(set) var inputSearchService: InputSearchService = .init(style: .init(state: .default))
    
    // MARK: - Init
    
    public init(
        view: InputSearchViewController = .init(),
        viewProperties: InputSearchViewController.ViewProperties = .init()
    ) {
        self.view = view
        self.viewProperties = viewProperties
        
        self.viewProperties.inputSearch = self.inputSearchService.view
        update()
    }
    
    // MARK: - Methods
    
    public func update() {
        view.update(with: viewProperties)
    }
}
