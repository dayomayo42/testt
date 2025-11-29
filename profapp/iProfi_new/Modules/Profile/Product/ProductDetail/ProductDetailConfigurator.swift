//
//  ProductDetailConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 13.10.2020.
//

import Foundation
import UIKit

protocol ProductDetailConfiguratorProtocol: class {
    func configure(with viewController: ProductDetailController)
}

class ProductDetailConfigurator: ProductDetailConfiguratorProtocol {
    func configure(with viewController: ProductDetailController) {
        let presenter = ProductDetailPresenter()
        let interactor = ProductDetailInteractor(viewController: viewController, presenter: presenter)
        let router = ProductDetailRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

