//
//  SaleDistributorsConfigurator.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation

protocol SalesDistributorsConfiguratorProtocol {
    func configure(with viewController: SalesDistributorsController)
}

class SalesDistributorsConfigurator: SalesDistributorsConfiguratorProtocol {
    func configure(with viewController: SalesDistributorsController) {
        let presenter = SalesDistributorsPresenter()
        let interactor = SalesDistributorsInteractor(viewController: viewController, presenter: presenter)
        let router = SalesDistributorsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
