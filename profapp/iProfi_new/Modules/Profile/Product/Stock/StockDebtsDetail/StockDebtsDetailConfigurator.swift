//
//  StockDebtsDetailConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.11.2020.
//

import Foundation
import UIKit

protocol StockDebtsDetailConfiguratorProtocol: class {
    func configure(with viewController: StockDebtsDetailController)
}

class StockDebtsDetailConfigurator: StockDebtsDetailConfiguratorProtocol {
    func configure(with viewController: StockDebtsDetailController) {
        let presenter = StockDebtsDetailPresenter()
        let interactor = StockDebtsDetailInteractor(viewController: viewController, presenter: presenter)
        let router = StockDebtsDetailRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

