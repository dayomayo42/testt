//
//  StockConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.04.2021.
//

import Foundation
import UIKit

protocol StockConfiguratorProtocol: class {
    func configure(with viewController: StockController)
}

class StockConfigurator: StockConfiguratorProtocol {
    func configure(with viewController: StockController) {
        let presenter = StockPresenter()
        let interactor = StockInteractor(viewController: viewController, presenter: presenter)
        let router = StockRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

