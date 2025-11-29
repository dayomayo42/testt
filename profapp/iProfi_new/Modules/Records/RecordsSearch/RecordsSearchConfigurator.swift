//
//  RecordsSearchConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.10.2020.
//

import Foundation
import UIKit

protocol RecordsSearchConfiguratorProtocol: class {
    func configure(with viewController: RecordsSearchController)
}

class RecordsSearchConfigurator: RecordsSearchConfiguratorProtocol {
    func configure(with viewController: RecordsSearchController) {
        let presenter = RecordsSearchPresenter()
        let interactor = RecordsSearchInteractor(viewController: viewController, presenter: presenter)
        let router = RecordsSearchRouter(viewController: viewController)

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
