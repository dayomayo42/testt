//
//  AddClientPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 25.10.2020.
//

import Foundation
import UIKit

protocol AddClientPresenterProtocol: ChooseCountryDelegate {
    var router: AddClientRouterProtocol! { get set }
    func configureView()
    func backAction()
    func openChooseCountry()
    func checkField()
    func postClient(model: CreateClientModel)
    func choosePhoto()
}

class AddClientPresenter: AddClientPresenterProtocol {
    func configureView(from model: CountriesModel?) {
        interactor.configureView(with: model)
    }
    
    var router: AddClientRouterProtocol!
    var interactor: AddClientInteractorProtocol!

    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openChooseCountry() {
        interactor.toCountryList()
    }
    
    func checkField() {
        interactor.checkField()
    }
    
    func postClient(model: CreateClientModel) {
        interactor.postClient(model: model)
    }
    
    func choosePhoto() {
        interactor.choosePhoto()
    }
}
