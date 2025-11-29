//
//  SettingsPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 03.11.2020.
//

import Foundation
import UIKit

protocol SettingsPresenterProtocol: class {
    var router: SettingsRouterProtocol! { get set }
    func configureView()
    func backAction()
    func chooseCurrency()
    func configure(with model: CurrencyModel)
    func accessCalendar()
}

class SettingsPresenter: SettingsPresenterProtocol {
    var router: SettingsRouterProtocol!
    var interactor: SettingsInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func chooseCurrency() {
        interactor.chooseCurrency()
    }
    
    func configure(with model: CurrencyModel) {
        interactor.configure(with: model)
    }

    func accessCalendar() {
        interactor.accessCalendar()
    }
}

