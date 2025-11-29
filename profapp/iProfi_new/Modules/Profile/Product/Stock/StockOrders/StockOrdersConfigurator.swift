//
//  StockOrdersConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 10.11.2020.
//

import Foundation
import UIKit

protocol StockOrdersConfiguratorProtocol: class {
    func configure(with viewController: StockOrdersController)
}

class StockOrdersConfigurator: StockOrdersConfiguratorProtocol {
    func configure(with viewController: StockOrdersController) {
        let presenter = StockOrdersPresenter()
        let interactor = StockOrdersInteractor(viewController: viewController, presenter: presenter)
        let router = StockOrdersRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

