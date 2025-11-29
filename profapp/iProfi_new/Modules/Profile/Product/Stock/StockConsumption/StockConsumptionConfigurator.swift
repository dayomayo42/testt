//
//  StockConsumptionConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.12.2020.
//

import Foundation
import UIKit

protocol StockConsumptionConfiguratorProtocol: class {
    func configure(with viewController: StockConsumptionController)
}

class StockConsumptionConfigurator: StockConsumptionConfiguratorProtocol {
    func configure(with viewController: StockConsumptionController) {
        let presenter = StockConsumptionPresenter()
        let interactor = StockConsumptionInteractor(viewController: viewController, presenter: presenter)
        let router = StockConsumptionRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

