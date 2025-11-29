//
//  InfoblockConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import Foundation
import UIKit

protocol InfoblockConfiguratorProtocol: class {
    func configure(with viewController: InfoblockController)
}

class InfoblockConfigurator: InfoblockConfiguratorProtocol {
    func configure(with viewController: InfoblockController) {
        let presenter = InfoblockPresenter()
        let interactor = InfoblockInteractor(viewController: viewController, presenter: presenter)
        let router = InfoblockRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
