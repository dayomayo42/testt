//
//  RecordsConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import Foundation
import UIKit

protocol RecordsConfiguratorProtocol: class {
    func configure(with viewController: RecordsController)
}

class RecordsConfigurator: RecordsConfiguratorProtocol {
    func configure(with viewController: RecordsController) {
        let presenter = RecordsPresenter()
        let interactor = RecordsInteractor(viewController: viewController, presenter: presenter)
        let router = RecordsRouter(viewController: viewController)

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
