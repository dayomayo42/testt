//
//  SalesConfigurator.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation

protocol SalesConfiguratorProtocol {
    func configure(with viewController: SalesController)
}

class SalesConfigurator: SalesConfiguratorProtocol {
    func configure(with viewController: SalesController) {
        let presenter = SalesPresenter()
        let interactor = SalesInteractor(viewController: viewController, presenter: presenter)
        let router = SalesRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
