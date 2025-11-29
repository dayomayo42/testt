//
//  ProfileConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import Foundation
import UIKit

protocol ProfileConfiguratorProtocol: class {
    func configure(with viewController: ProfileController)
}

class ProfileConfigurator: ProfileConfiguratorProtocol {
    func configure(with viewController: ProfileController) {
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor(viewController: viewController, presenter: presenter)
        let router = ProfileRouter(viewController: viewController)

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
