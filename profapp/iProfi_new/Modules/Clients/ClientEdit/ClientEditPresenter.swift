//
//  ClientEditPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 07.10.2020.
//

import Foundation
import UIKit

protocol ClientEditPresenterProtocol: ChooseCountryDelegate {
    var router: ClientEditRouterProtocol! { get set }
    func configureView()
    func configureView(with model: Client)
    func backAction()
    func openChooseCountry()
    func deleteUser(with id: Int)
    func editUser(with model: Client)
    func checkFields() -> Bool
}

class ClientEditPresenter: ClientEditPresenterProtocol {
    func configureView(from model: CountriesModel?) {
        interactor.configureView(with: model)
    }
    
    var router: ClientEditRouterProtocol!
    var interactor: ClientEditInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }

    func configureView(with model: Client) {
        interactor.configureView(with: model)
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openChooseCountry() {
        interactor.toCountryList()
    }
    
    func deleteUser(with id: Int) {
        interactor.deleteUser(with: id)
    }
    
    func editUser(with model: Client) {
        interactor.editUser(with: model)
    }
    
    func checkFields() -> Bool {
        interactor.checkFields()
    }
}
