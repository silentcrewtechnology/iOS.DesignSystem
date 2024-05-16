//
//  ToggleViewExample.swift
//
//
//  Created by user on 13.05.2024.
//

import Foundation
import Components

private func example() {
    var toggleStyle = ToggleViewStyle(state: .default)
    let toggleView = ToggleView()
    
    var viewProperties = ToggleView.ViewProperties() { isOn in
        print(isOn)
    }
    toggleStyle.update(viewProperties: &viewProperties)
    toggleView.update(with: viewProperties)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        toggleStyle.state = .disabled
        toggleStyle.update(viewProperties: &viewProperties)
        viewProperties.isChecked = true
        toggleView.update(with: viewProperties)
    }
}
