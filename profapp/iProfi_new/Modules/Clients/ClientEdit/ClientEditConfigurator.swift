//
//  ClientEditConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 07.10.2020.
//

import Foundation
import UIKit

protocol ClientEditConfiguratorProtocol: class {
    func configure(with viewController: ClientEditController)
}

class ClientEditConfigurator: ClientEditConfiguratorProtocol {
    func configure(with viewController: ClientEditController) {
        let presenter = ClientEditPresenter()
        let interactor = ClientEditInteractor(viewController: viewController, presenter: presenter)
        let router = ClientEditRouter(viewController: viewController)

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
