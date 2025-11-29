//
//  ClientsConfiguration.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import Foundation
import UIKit

protocol ClientsConfiguratorProtocol: class {
    func configure(with viewController: ClientsController)
}

class ClientsConfigurator: ClientsConfiguratorProtocol {
    func configure(with viewController: ClientsController) {
        let presenter = ClientsPresenter()
        let interactor = ClientsInteractor(viewController: viewController, presenter: presenter)
        let router = ClientsRouter(viewController: viewController)

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
