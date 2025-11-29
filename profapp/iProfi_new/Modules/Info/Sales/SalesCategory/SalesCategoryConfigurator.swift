//
//  SalesCategoryConfigurator.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation

protocol SalesCategoryConfiguratorProtocol {
    func configure(with viewController: SalesCategoryController)
}

class SalesCategoryConfigurator: SalesCategoryConfiguratorProtocol {
    func configure(with viewController: SalesCategoryController) {
        let presenter = SalesCategoryPresenter()
        let interactor = SalesCategoryInteractor(viewController: viewController, presenter: presenter)
        let router = SalesCategoryRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
