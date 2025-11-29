//
//  ProfileDetailConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 23.10.2020.
//

import Foundation
import UIKit

protocol ProfileDetailConfiguratorProtocol: class {
    func configure(with viewController: ProfileDetailController)
}

class ProfileDetailConfigurator: ProfileDetailConfiguratorProtocol {
    func configure(with viewController: ProfileDetailController) {
        let presenter = ProfileDetailPresenter()
        let interactor = ProfileDetailInteractor(viewController: viewController, presenter: presenter)
        let router = ProfileDetailRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

