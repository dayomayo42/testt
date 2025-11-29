//
//  ProductCategoryAddConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 08.10.2020.
//

import Foundation
import UIKit

protocol ProductCategoryAddConfiguratorProtocol: class {
    func configure(with viewController: ProductCategoryAddController)
}

class ProductCategoryAddConfigurator: ProductCategoryAddConfiguratorProtocol {
    func configure(with viewController: ProductCategoryAddController) {
        let presenter = ProductCategoryAddPresenter()
        let interactor = ProductCategoryAddInteractor(viewController: viewController, presenter: presenter)
        let router = ProductCategoryAddRouter(viewController: viewController)

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
