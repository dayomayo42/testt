//
//  SupplierAddConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import Foundation
import UIKit

protocol SupplierAddConfiguratorProtocol: class {
    func configure(with viewController: SupplierAddController)
}

class SupplierAddConfigurator: SupplierAddConfiguratorProtocol {
    func configure(with viewController: SupplierAddController) {
        let presenter = SupplierAddPresenter()
        let interactor = SupplierAddInteractor(viewController: viewController, presenter: presenter)
        let router = SupplierAddRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

