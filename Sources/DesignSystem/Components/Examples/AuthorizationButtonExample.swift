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
    var viewProperties = AuthorizationButtonStyle.update(
        style: .gosuslugi,
        isInversed: true,
        viewProperties: .init(
            image: .ic24Book,
            title: "Войти через Госуслуги".attributed
        )
    )
    viewProperties.onTap = { print("tapped") }
    view.update(with: viewProperties)
}
