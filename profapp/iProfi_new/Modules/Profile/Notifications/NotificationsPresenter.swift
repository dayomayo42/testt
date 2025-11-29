//
//  NotificationsPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.12.2020.
//

import Foundation
import UIKit

protocol NotificationsPresenterProtocol: class {
    var router: NotificationsRouterProtocol! { get set }
    func configureView()
    func backAction()
    func getNotification()
    func postAccept(id: Int)
    func postCancel(id: Int)
    func openDetail(record: Records, status: Int)
}

class NotificationsPresenter: NotificationsPresenterProtocol {
    var router: NotificationsRouterProtocol!
    var interactor: NotificationsInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func getNotification() {
        interactor.getNotification()
    }
    
    func postAccept(id: Int) {
        interactor.postAccept(id: id)
    }
    
    func postCancel(id: Int) {
        interactor.postCancel(id: id)
    }
    
    func openDetail(record: Records, status: Int) {
        interactor.openDetail(record: record, status: status)
    }
}


