//
//  RecordsProductCategoryCofigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 18.01.2021.
//

import Foundation
import UIKit

protocol RecordsProductCategoryConfiguratorProtocol: class {
    func configure(with viewController: RecordsProductCategoryController)
}

class RecordsProductCategoryConfigurator: RecordsProductCategoryConfiguratorProtocol {
    func configure(with viewController: RecordsProductCategoryController) {
        let presenter = RecordsProductCategoryPresenter()
        let interactor = RecordsProductCategoryInteractor(viewController: viewController, presenter: presenter)
        let router = RecordsProductCategoryRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

