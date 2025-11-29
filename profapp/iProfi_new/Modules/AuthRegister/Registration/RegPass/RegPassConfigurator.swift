//
//  RegPassConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 03.09.2020.
//

import Foundation

protocol RegPassConfiguratorProtocol: class {
    func configure(with viewController: RegPassController)
}

class RegPassConfigurator: RegPassConfiguratorProtocol {
    func configure(with viewController: RegPassController) {
        let presenter = RegPassPresenter()
        let interactor = RegPassInteractor(viewController: viewController, presenter: presenter)
        let router = RegPassRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
