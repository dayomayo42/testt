//
//  ClientDetailConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.10.2020.
//

import Foundation
import UIKit

protocol ClientDetailConfiguratorProtocol: class {
    func configure(with viewController: ClientDetailController)
}

class ClientDetailConfigurator: ClientDetailConfiguratorProtocol {
    func configure(with viewController: ClientDetailController) {
        let presenter = ClientDetailPresenter()
        let interactor = ClientDetailInteractor(viewController: viewController, presenter: presenter)
        let router = ClientDetailRouter(viewController: viewController)

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
