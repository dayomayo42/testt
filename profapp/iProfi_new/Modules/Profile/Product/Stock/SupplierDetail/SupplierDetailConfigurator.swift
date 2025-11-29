//
//  SupplierDetailConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 16.10.2020.
//

import Foundation
import UIKit

protocol SupplierDetailConfiguratorProtocol: class {
    func configure(with viewController: SupplierDetailController)
}

class SupplierDetailConfigurator: SupplierDetailConfiguratorProtocol {
    func configure(with viewController: SupplierDetailController) {
        let presenter = SupplierDetailPresenter()
        let interactor = SupplierDetailInteractor(viewController: viewController, presenter: presenter)
        let router = SupplierDetailRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

