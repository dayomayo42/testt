//
//  RecordsCalendarConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 16.11.2020.
//

import Foundation
import UIKit

protocol RecordsCalendarConfiguratorProtocol: class {
    func configure(with viewController: RecordsCalendarController)
}

class RecordsCalendarConfigurator: RecordsCalendarConfiguratorProtocol {
    func configure(with viewController: RecordsCalendarController) {
        let presenter = RecordsCalendarPresenter()
        let interactor = RecordsCalendarInteractor(viewController: viewController, presenter: presenter)
        let router = RecordsCalendarRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

