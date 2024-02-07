//
//  TextareaViewExample.swift
//  
//
//  Created by Ilnur Mugaev on 07.11.2023.
//

import UIKit

private func example() {
    
    let view = TextareaView()
    
    var viewProperties = TextareaView.ViewProperties(
        header: "Header".attributed,
        text: "Content".attributed,
        textViewHeight: .minimal,
        placeholder: "Placeholder".attributed,
        hint: "Максимум 150 символов".attributed,
        maxCount: .number(150))
    
    viewProperties = TextareaViewStyle.restyle(
        style: .default,
        viewProperties: viewProperties)
    
    view.create(with: viewProperties)
    
    viewProperties = TextareaViewStyle.restyle(
        style: .disabled,
        viewProperties: viewProperties)
    
    view.update(with: viewProperties)
}
