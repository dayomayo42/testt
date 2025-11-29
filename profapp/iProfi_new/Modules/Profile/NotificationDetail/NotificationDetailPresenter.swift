//
//  NotificationDetailPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 03.12.2020.
//

import Foundation
import UIKit

protocol NotificationDetailPresenterProtocol: class {
    var router: NotificationDetailRouterProtocol! { get set }
    func configureView()
    func backAction()
    func postAccept(id: Int)
    func postCancel(id: Int)
    func openPhone(with num: String)
    func editAction(with model: Records, type: RecordsType)
}

class NotificationDetailPresenter: NotificationDetailPresenterProtocol {
    var router: NotificationDetailRouterProtocol!
    var interactor: NotificationDetailInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func postAccept(id: Int) {
        interactor.postAccept(id: id)
    }
    
    func postCancel(id: Int) {
        interactor.postCancel(id: id)
    }
    
    func openPhone(with num: String) {
        interactor.openPhone(with: num)
    }
    
    func editAction(with model: Records, type: RecordsType) {
        interactor.editAction(with: model, type: type)
    }
}


