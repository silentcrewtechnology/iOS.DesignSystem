//
//  ToggleViewExample.swift
//
//
//  Created by user on 13.05.2024.
//

import Foundation
import Components

private func example() {
    let toggleStyle = ToggleViewStyle()
    let toggleView = ToggleView()
    
    var viewProperties = ToggleView.ViewProperties() { isOn in
        print(isOn)
    }
    toggleStyle.update(variant: .default, viewProperties: &viewProperties)
    toggleView.update(with: viewProperties)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        toggleStyle.update(variant: .disabled, viewProperties: &viewProperties)
        viewProperties.isChecked = true
        toggleView.update(with: viewProperties)
    }
}
