//
//  StockDebtsConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.11.2020.
//

import Foundation
import UIKit

protocol StockDebtsConfiguratorProtocol: class {
    func configure(with viewController: StockDebtsController)
}

class StockDebtsConfigurator: StockDebtsConfiguratorProtocol {
    func configure(with viewController: StockDebtsController) {
        let presenter = StockDebtsPresenter()
        let interactor = StockDebtsInteractor(viewController: viewController, presenter: presenter)
        let router = StockDebtsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

