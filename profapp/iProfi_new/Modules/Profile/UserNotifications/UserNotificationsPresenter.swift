//
//  UserNotificationsPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 31.08.2021.
//

import Foundation
import UIKit

protocol UserNotificationsPresenterProtocol {
    var router: UserNotificationsRouterProtocol! { get set }
    func configureView()
    func backAction()
    func showAlert(model: ClientNotif)
    func getReminders()
    func setReaded()
    func openSubs()
    func openSettings()
}

class UserNotificationsPresenter: UserNotificationsPresenterProtocol {
    var router: UserNotificationsRouterProtocol!
    var interactor: UserNotificationsInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func showAlert(model: ClientNotif) {
        interactor.showAlert(model: model)
    }
    
    func getReminders() {
        interactor.getReminders()
    }
    
    func setReaded() {
        interactor.setReaded()
    }
    
    func openSubs() {
        router.openSubs()
    }
    
    func openSettings() {
        router.openSettings()
    }
}


