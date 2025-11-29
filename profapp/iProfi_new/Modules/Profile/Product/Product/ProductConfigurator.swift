//
//  ProductConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 07.10.2020.
//

import Foundation
import UIKit

protocol ProductConfiguratorProtocol: class {
    func configure(with viewController: ProductController)
}

class ProductConfigurator: ProductConfiguratorProtocol {
    func configure(with viewController: ProductController) {
        let presenter = ProductPresenter()
        let interactor = ProductInteractor(viewController: viewController, presenter: presenter)
        let router = ProductRouter(viewController: viewController)

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
