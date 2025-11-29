//
//  OnlineRecordSettingsConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.12.2020.
//

import Foundation
import UIKit

protocol OnlineRecordSettingsConfiguratorProtocol: class {
    func configure(with viewController: OnlineRecordSettingsController)
}

class OnlineRecordSettingsConfigurator: OnlineRecordSettingsConfiguratorProtocol {
    func configure(with viewController: OnlineRecordSettingsController) {
        let presenter = OnlineRecordSettingsPresenter()
        let interactor = OnlineRecordSettingsInteractor(viewController: viewController, presenter: presenter)
        let router = OnlineRecordSettingsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

