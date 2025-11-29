//
//  StockProdutsConfiguatorr.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.11.2020.
//

import Foundation
import UIKit

protocol StockProdutsConfiguratorProtocol: class {
    func configure(with viewController: StockProdutsController)
}

class StockProdutsConfigurator: StockProdutsConfiguratorProtocol {
    func configure(with viewController: StockProdutsController) {
        let presenter = StockProdutsPresenter()
        let interactor = StockProdutsInteractor(viewController: viewController, presenter: presenter)
        let router = StockProdutsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

