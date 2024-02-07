//
//  SelectViewExample.swift
//
//
//  Created by Ilnur Mugaev on 20.12.2023.
//

import UIKit

private func example() {
    
    let view = SelectView()
    
    var properties = SelectViewStyle.restyle(
        style: .default,
        viewProperties: .init(
            header: "Header".attributed,
            text: "Content".attributed,
            placeholder: "Placeholder".attributed,
            hint: "Hint".attributed,
            isHintHidden: true,
            clearButtonIsHidden: false))
    
    properties.clearButtonAction = { [weak view] in
        properties.text = "".attributed
        view?.update(with: properties)
    }
    
    properties.inputTapAction = { [weak view] in
        properties = SelectViewStyle.restyle(
            style: .active,
            viewProperties: properties)
        view?.update(with: properties)
        properties.text = "Content 2".attributed
        properties = SelectViewStyle.restyle(
            style: .default,
            viewProperties: properties)
        view?.update(with: properties)
    }
    
    view.update(with: properties)
}
