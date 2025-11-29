//
//  RecordsCalendarMonthConfigurator.swift
//  iProfi_new
//
//  Created by violy on 26.04.2023.
//

import Foundation

protocol RecordsCalendarMonthConfiguratorProtocol {
    func configure(with viewController: RecordsCalendarMonthController)
}

class RecordsCalendarMonthConfigurator: RecordsCalendarMonthConfiguratorProtocol {
    func configure(with viewController: RecordsCalendarMonthController) {
        let presenter = RecordsCalendarMonthPresenter()
        let interactor = RecordsCalendarMonthInteractor(viewController: viewController, presenter: presenter)
        let router = RecordsCalendarMonthRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
