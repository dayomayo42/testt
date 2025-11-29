//
//  RegPhoneConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.09.2020.
//

import Foundation
import UIKit

protocol RegPhoneConfiguratorProtocol: class {
    func configure(with viewController: RegPhoneController)
}

class RegPhoneConfigurator: RegPhoneConfiguratorProtocol {
    func configure(with viewController: RegPhoneController) {
        let presenter = RegPhonePresenter()
        let interactor = RegPhoneInteractor(viewController: viewController, presenter: presenter)
        let router = RegPhoneRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
