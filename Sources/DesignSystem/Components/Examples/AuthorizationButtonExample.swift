//
//  AuthorizationButtonExample.swift
//
//
//  Created by Ilnur Mugaev on 21.03.2024.
//

import UIKit
import Components

private func example() {
    let view = AuthorizationButton()
    let style = AuthorizationButtonStyle(
        variant: .gosuslugi,
        isInversed: true
    )
    var viewProperties = AuthorizationButton.ViewProperties(
        image: .ic24Book,
        title: "Войти через Госуслуги".attributed,
        onTap: { print("tapped") }
    )
    style.update(viewProperties: &viewProperties)
    view.update(with: viewProperties)
}
