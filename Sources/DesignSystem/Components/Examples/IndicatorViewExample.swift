//
//  IndicatorViewExample.swift
//  
//
//  Created by user on 25.03.2024.
//

import UIKit
import Components

private class Example {
    
    func exampleSuccessSizeL() {
        let view = IndicatorView()
        var viewProperties = IndicatorView.ViewProperties()
        let style = IndicatorViewStyle(style: .success, size: .sizeL)
        style.update(viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
    
    func exampleDangerSizeS() {
        let view = IndicatorView()
        var viewProperties = IndicatorView.ViewProperties()
        let style = IndicatorViewStyle(style: .danger, size: .sizeS)
        style.update(viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
}
