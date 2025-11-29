//
//  RecordsCalendarWeekConfigurator.swift
//  iProfi_new
//
//  Created by violy on 12.05.2023.
//

import Foundation

protocol RecordsCalendarWeekConfiguratorProtocol {
    func configure(with viewController: RecordsCalendarWeekViewController)
}

class RecordsCalendarWeekConfigurator: RecordsCalendarWeekConfiguratorProtocol {
    func configure(with viewController: RecordsCalendarWeekViewController) {
        let presenter = RecordsCalendarWeekPresenter()
        let interactor = RecordsCalendarWeekInteractor(viewController: viewController, presenter: presenter)
        let router = RecordsCalendarWeekRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
