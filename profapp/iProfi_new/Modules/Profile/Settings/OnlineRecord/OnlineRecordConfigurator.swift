//
//  OnlineRecordConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 29.10.2020.
//

import Foundation
import UIKit

protocol OnlineRecordConfiguratorProtocol: class {
    func configure(with viewController: OnlineRecordController)
}

class OnlineRecordConfigurator: OnlineRecordConfiguratorProtocol {
    func configure(with viewController: OnlineRecordController) {
        let presenter = OnlineRecordPresenter()
        let interactor = OnlineRecordInteractor(viewController: viewController, presenter: presenter)
        let router = OnlineRecordRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

