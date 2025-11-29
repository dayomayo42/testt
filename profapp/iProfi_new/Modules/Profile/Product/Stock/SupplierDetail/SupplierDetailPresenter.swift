//
//  SupplierDetailPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 16.10.2020.
//

import Foundation
import UIKit

protocol SupplierDetailPresenterProtocol: ChooseCountryDelegate {
    var router: SupplierDetailRouterProtocol! { get set }
    func configureView()
    func configureView(from model: Supplier)
    func backAction()
    func openChooseCountry()
    func editMode(edit: Bool)
    func share(link: String)
    func deleteSupplier()
}

class SupplierDetailPresenter: SupplierDetailPresenterProtocol {
    var router: SupplierDetailRouterProtocol!
    var interactor: SupplierDetailInteractorProtocol!
    
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
    
    func editMode(edit: Bool) {
        interactor.editMode(edit: edit)
    }
    
    func share(link: String) {
        interactor.share(link: link)
    }
    
    func configureView(from model: Supplier) {
        interactor.configureView(from: model)
    }
    
    func deleteSupplier() {
        interactor.deleteSupplier()
    }
}

