//
//  RecordDetailConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import Foundation
import UIKit

protocol RecordDetailConfiguratorProtocol: class {
    func configure(with viewController: RecordDetailController)
}

class RecordDetailConfigurator: RecordDetailConfiguratorProtocol {
    func configure(with viewController: RecordDetailController) {
        let presenter = RecordDetailPresenter()
        let interactor = RecordDetailInteractor(viewController: viewController, presenter: presenter)
        let router = RecordDetailRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

