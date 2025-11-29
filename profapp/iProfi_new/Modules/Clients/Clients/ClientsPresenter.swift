//
//  ClientsPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import Foundation
import UIKit

protocol ClientsPresenterProtocol: class {
    var router: ClientsRouterProtocol! { get set }
    func configureView()
    func clientsDetail(model: Client)
    func checkCacheClients()
    func getClients()
    func addClient()
    func choose(model: Client)
    func backAction()
    
    func manualAddClient()
    func contactAddClient()
    
    func sortArray(with string: String)
    func multiChoose(clients: [Client])
}

class ClientsPresenter: ClientsPresenterProtocol {
    var router: ClientsRouterProtocol!
    var interactor: ClientsInteractorProtocol!

    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func clientsDetail(model: Client) {
        interactor.clientsDetail(model: model)
    }
    
    func checkCacheClients() {
        interactor.checkCacheClients()
    }
    
    func getClients() {
        interactor.getClients()
    }
    
    func addClient() {
        interactor.addClient()
    }
    
    func choose(model: Client) {
        interactor.choose(model: model)
    }
    
    func manualAddClient() {
        interactor.manualAddClient()
    }
    
    
    func contactAddClient() {
        interactor.contactAddClient()
    }
    
    func sortArray(with string: String) {
        interactor.sortArray(with: string)
    }
    
    func multiChoose(clients: [Client]) {
        interactor.multiChoose(clients: clients)
    }
}
