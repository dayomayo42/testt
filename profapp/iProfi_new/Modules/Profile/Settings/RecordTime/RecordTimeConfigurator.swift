//
//  RecordTimeConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 05.11.2020.
//

import Foundation
import UIKit

protocol RecordTimeConfiguratorProtocol: class {
    func configure(with viewController: RecordTimeController)
}

class RecordTimeConfigurator: RecordTimeConfiguratorProtocol {
    func configure(with viewController: RecordTimeController) {
        let presenter = RecordTimePresenter()
        let interactor = RecordTimeInteractor(viewController: viewController, presenter: presenter)
        let router = RecordTimeRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

