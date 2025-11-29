//
//  StockArrivalConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.12.2020.
//

import Foundation
import UIKit

protocol StockArrivalConfiguratorProtocol: class {
    func configure(with viewController: StockArrivalController)
}

class StockArrivalConfigurator: StockArrivalConfiguratorProtocol {
    func configure(with viewController: StockArrivalController) {
        let presenter = StockArrivalPresenter()
        let interactor = StockArrivalInteractor(viewController: viewController, presenter: presenter)
        let router = StockArrivalRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

