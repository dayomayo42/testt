//
//  CatgoryDetailConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 12.10.2020.
//

import Foundation
import UIKit

protocol CategoryDetailConfiguratorProtocol: class {
    func configure(with viewController: CategoryDetailController)
}

class CategoryDetailConfigurator: CategoryDetailConfiguratorProtocol {
    func configure(with viewController: CategoryDetailController) {
        let presenter = CategoryDetailPresenter()
        let interactor = CategoryDetailInteractor(viewController: viewController, presenter: presenter)
        let router = CategoryDetailRouter(viewController: viewController)

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
