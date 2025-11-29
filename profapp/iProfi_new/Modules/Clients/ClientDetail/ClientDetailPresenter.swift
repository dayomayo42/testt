//
//  ClientDetailPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.10.2020.
//

import Foundation
import UIKit

protocol ClientDetailPresenterProtocol: class {
    var router: ClientDetailRouterProtocol! { get set }
    func configureView()
    func backAction()
    func editAction()
    func choosePhoto()
    func postPhoto()
    func callAction(num: String)
    func addClientRecord()
    func getClient()
    func openRecord(model: Records)
    func changeStatus()
    func editUser()
}

class ClientDetailPresenter: ClientDetailPresenterProtocol {
    var router: ClientDetailRouterProtocol!
    var interactor: ClientDetailInteractorProtocol!

    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func editAction() {
        interactor.editAction()
    }
    
    func choosePhoto() {
        interactor.choosePhoto()
    }
    
    func postPhoto() {
        interactor.postPhoto()
    }
    
    func callAction(num: String) {
        interactor.callAction(num: num)
    }
    
    func addClientRecord() {
        interactor.addClientRecord()
    }
    
    func getClient() {
        interactor.getClient()
    }
    
    func openRecord(model: Records) {
        interactor.openRecord(model: model)
    }
    
    func changeStatus() {
        interactor.changeStatus()
    }
    
    func editUser() {
        interactor.editUser()
    }
}
