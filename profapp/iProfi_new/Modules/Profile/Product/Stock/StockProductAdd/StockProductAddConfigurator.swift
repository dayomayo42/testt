//
//  StockProductAddConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.11.2020.
//

import Foundation
import UIKit

protocol StockProductAddConfiguratorProtocol: class {
    func configure(with viewController: StockProductAddController)
}

class StockProductAddConfigurator: StockProductAddConfiguratorProtocol {
    func configure(with viewController: StockProductAddController) {
        let presenter = StockProductAddPresenter()
        let interactor = StockProductAddInteractor(viewController: viewController, presenter: presenter)
        let router = StockProductAddRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

