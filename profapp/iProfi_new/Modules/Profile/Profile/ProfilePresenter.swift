//
//  ProfilePresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import Foundation
import UIKit

protocol ProfilePresenterProtocol: class {
    var router: ProfileRouterProtocol! { get set }
    func configureView()
    func logoutAction()
    func productAction()
    func servicesAction()
    func getProfile()
    func openDetail()
    func getUserModel() -> UserModel
    func choosePhoto()
    func postPhoto()
    func openSupport()
    func openShedule()
    func openOnlineRecord()
    func shareApp()
    func openSettings()
    func openNotifications()
    func openNotificationSettings()
    func openReview()
    func openSubscription()
    func stockAction()
    func openUserNotification()
}

class ProfilePresenter: ProfilePresenterProtocol {
    var router: ProfileRouterProtocol!
    var interactor: ProfileInteractorProtocol!

    func configureView() {
        interactor.configureView()
    }
    
    func logoutAction() {
        interactor.logoutAction()
    }
    
    func productAction() {
        interactor.productAction()
    }
    
    func servicesAction() {
        interactor.servicesAction()
    }
    
    func getProfile() {
        interactor.getProfile()
    }
    func getUserModel() -> UserModel {
        interactor.userModel!
    }
    
    func openDetail() {
        interactor.openDetail()
    }
    
    func choosePhoto() {
        interactor.choosePhoto()
    }
    
    func postPhoto() {
        interactor.postPhoto()
    }
    
    func openSupport() {
        interactor.openSupport()
    }
    
    func openShedule() {
        interactor.openShedule()
    }
    
    func openOnlineRecord() {
        interactor.openOnlineRecord()
    }
    
    func shareApp() {
        interactor.shareApp()
    }
    
    func openSettings() {
        interactor.openSettings()
    }
    
    func openNotifications() {
        interactor.openNotifications()
    }
    
    func openNotificationSettings() {
        interactor.openNotificationSettings()
    }
    
    func openReview() {
        interactor.openReview()
    }
    
    func openSubscription() {
        interactor.openSubscription()
    }
    
    func stockAction() {
        interactor.stockAction()
    }
    
    func openUserNotification() {
        interactor.openUserNotification()
    }
}
