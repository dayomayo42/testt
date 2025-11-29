//
//  SalesDistributorsDetailConfigurator.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation

protocol SalesDistributorsDetailConfiguratorProtocol {
    func configure(with viewController: SalesDistributorsDetailController)
}

class SalesDistributorsDetailConfigurator: SalesDistributorsDetailConfiguratorProtocol {
    func configure(with viewController: SalesDistributorsDetailController) {
        let presenter = SalesDistributorsDetailPresenter()
        let interactor = SalesDistributorsDetailInteractor(viewController: viewController, presenter: presenter)
        let router = SalesDistributorsDetailRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
