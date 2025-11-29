//
//  RegInfoConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 09.09.2020.
//

import Foundation
import UIKit

protocol RegInfoConfiguratorProtocol: class {
    func configure(with viewController: RegInfoController)
}

class RegInfoConfigurator: RegInfoConfiguratorProtocol {
    func configure(with viewController: RegInfoController) {
        let presenter = RegInfoPresenter()
        let interactor = RegInfoInteractor(viewController: viewController, presenter: presenter)
        let router = RegInfoRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
