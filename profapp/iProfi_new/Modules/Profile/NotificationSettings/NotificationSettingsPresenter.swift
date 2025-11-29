//
//  NotificationSettingsPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 09.12.2020.
//

import Foundation
import UIKit

protocol NotificationSettingsPresenterProtocol: class {
    var router: NotificationSettingsRouterProtocol! { get set }
    func configureView()
    func backAction()
    func openDetail(with type: NotificationsType)
    func getSettings()
}

class NotificationSettingsPresenter: NotificationSettingsPresenterProtocol {
    var router: NotificationSettingsRouterProtocol!
    var interactor: NotificationSettingsInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openDetail(with type: NotificationsType) {
        interactor.openDetail(with: type)
    }
    
    func getSettings() {
        interactor.getSettings()
    }
    
}


