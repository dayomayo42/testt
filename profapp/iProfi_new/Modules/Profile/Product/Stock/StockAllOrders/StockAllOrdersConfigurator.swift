//
//  StockAllOrdersConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.11.2020.
//

import Foundation
import UIKit

protocol StockAllOrdersConfiguratorProtocol: class {
    func configure(with viewController: StockAllOrdersController)
}

class StockAllOrdersConfigurator: StockAllOrdersConfiguratorProtocol {
    func configure(with viewController: StockAllOrdersController) {
        let presenter = StockAllOrdersPresenter()
        let interactor = StockAllOrdersInteractor(viewController: viewController, presenter: presenter)
        let router = StockAllOrdersRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

