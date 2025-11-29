//
//  SupplierAddPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import Foundation
import UIKit

protocol SupplierAddPresenterProtocol: ChooseCountryDelegate {
    var router: SupplierAddRouterProtocol! { get set }
    func configureView()
    func backAction()
    func openChooseCountry()
    func createAction()
}

class SupplierAddPresenter: SupplierAddPresenterProtocol {
    var router: SupplierAddRouterProtocol!
    var interactor: SupplierAddInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func configureView(from model: CountriesModel?) {
        interactor.configureView(from: model)
    }
    
    func openChooseCountry() {
        interactor.toCountryList()
    }
    
    func createAction() {
        interactor.createAction()
    }
}
