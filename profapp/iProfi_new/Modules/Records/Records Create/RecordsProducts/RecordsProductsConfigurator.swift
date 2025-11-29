//
//  RecordsProductsConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 26.10.2020.
//

import Foundation
import UIKit

protocol RecordsProductsConfiguratorProtocol: class {
    func configure(with viewController: RecordsProductsController)
}

class RecordsProductsConfigurator: RecordsProductsConfiguratorProtocol {
    func configure(with viewController: RecordsProductsController) {
        let presenter = RecordsProductsPresenter()
        let interactor = RecordsProductsInteractor(viewController: viewController, presenter: presenter)
        let router = RecordsProductsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

