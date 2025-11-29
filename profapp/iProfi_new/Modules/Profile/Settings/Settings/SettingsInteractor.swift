//
//  SettingsInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 03.11.2020.
//

import Foundation
import UIKit
import EventKit
import SVProgressHUD

protocol SettingsInteractorProtocol: class {
    func configureView()
    func chooseCurrency()
    func configure(with model: CurrencyModel)
    func accessCalendar()
}

class SettingsInteractor: SettingsInteractorProtocol {
    weak var viewController: SettingsController!
    weak var presenter: SettingsPresenterProtocol!
    
    init(viewController: SettingsController, presenter: SettingsPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        if Settings.currency == "" {
            Settings.currency = "RUB"
            Settings.currencyCym = "₽"
        }
        viewController.currencyView.setTitle(Settings.currency, for: .normal)
        
        viewController.switchView.isOn = Settings.calendar ?? false
    }
    
    func chooseCurrency() {
        let vc = viewController.getControllerProfile(controller: .currency) as! CurrencyBottom
        vc.delegate = viewController
        viewController.present(vc, animated: true, completion: nil)
    }
    
    func configure(with model: CurrencyModel) {
        Settings.currency = model.shortName
        Settings.currencyCym = model.cymbol
        viewController.currencyView.setTitle(model.shortName, for: .normal)
    }
    
    func accessCalendar() {
        let eventStore = EKEventStore()
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            print("Autorized")
            Settings.calendar = true
            viewController.switchView.isOn = true
        case .denied:
            SVProgressHUD.showError(withStatus: "Доступ запрещен")
            viewController.switchView.isOn = false
        case .notDetermined:
            eventStore.requestAccess(to: .event, completion: { [weak self] (granted: Bool, _: Error?) -> Void in
                if granted {
                    Settings.calendar = true
//                    self?.viewController.switchView.isOn = true
                } else {
                    SVProgressHUD.showError(withStatus: "Доступ запрещен")
//                    self?.viewController.switchView.isOn = false
                }
            })
        default:
            print("Case default")
        }
    }
}

