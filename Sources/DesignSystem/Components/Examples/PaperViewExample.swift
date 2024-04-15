//
//  PaperViewExample.swift
//
//
//  Created by Ilnur Mugaev on 03.12.2023.
//

import UIKit
import Components

private func example() {
    
    let view = PaperView()
    
    var viewProperties = PaperView.ViewProperties()
    PaperViewStyle(
        mask: .top,
        radius: .large,
        color: .primary,
        hasShadow: false)
    .update(viewProperties: &viewProperties)
    
    view.update(with: viewProperties)
    
    let rowsInSection = 3
    let indexPath = IndexPath(row: 1, section: 0)
    
    PaperViewStyle(
        mask: .automatic(
            rowsInSection: rowsInSection,
            indexPath: indexPath),
        radius: .large,
        color: .primary,
        hasShadow: false)
    .update(viewProperties: &viewProperties)
    
    view.update(with: viewProperties)
}
