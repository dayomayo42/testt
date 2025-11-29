//
//  StockProductDetailConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 09.11.2020.
//

import Foundation
import UIKit

protocol StockProductDetailConfiguratorProtocol: class {
    func configure(with viewController: StockProductDetailController)
}

class StockProductDetailConfigurator: StockProductDetailConfiguratorProtocol {
    func configure(with viewController: StockProductDetailController) {
        let presenter = StockProductDetailPresenter()
        let interactor = StockProductDetailInteractor(viewController: viewController, presenter: presenter)
        let router = StockProductDetailRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

