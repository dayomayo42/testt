//
//  StockBalanceConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 16.12.2020.
//

import Foundation
import UIKit

protocol StockBalanceConfiguratorProtocol: class {
    func configure(with viewController: StockBalanceController)
}

class StockBalanceConfigurator: StockBalanceConfiguratorProtocol {
    func configure(with viewController: StockBalanceController) {
        let presenter = StockBalancePresenter()
        let interactor = StockBalanceInteractor(viewController: viewController, presenter: presenter)
        let router = StockBalanceRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

