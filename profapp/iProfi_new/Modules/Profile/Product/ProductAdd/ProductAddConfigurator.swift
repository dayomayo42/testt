//
//  ProductDetailConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 12.10.2020.
//

import Foundation
import UIKit

protocol ProductAddConfiguratorProtocol: class {
    func configure(with viewController: ProductAddController)
}

class ProductAddConfigurator: ProductAddConfiguratorProtocol {
    func configure(with viewController: ProductAddController) {
        let presenter = ProductAddPresenter()
        let interactor = ProductAddInteractor(viewController: viewController, presenter: presenter)
        let router = ProductAddRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

