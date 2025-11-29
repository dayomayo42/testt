//
//  SuppliersPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import Foundation
import UIKit

protocol SuppliersPresenterProtocol: class {
    var router: SuppliersRouterProtocol! { get set }
    func configureView()
    func backAction()
    func addAction()
    func detailAction(with model: Supplier)
    func getSuppliers()
    func chooseSupplier(with model: Supplier)
    func search(string: String)
}

class SuppliersPresenter: SuppliersPresenterProtocol {
    var router: SuppliersRouterProtocol!
    var interactor: SuppliersInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func addAction() {
        interactor.addAction()
    }
    
    func detailAction(with model: Supplier) {
        interactor.detailAction(with: model)
    }
    
    func getSuppliers() {
        interactor.getSuppliers()
    }
    
    func chooseSupplier(with model: Supplier) {
        interactor.chooseSupplier(with: model)
    }
    
    func search(string: String) {
        interactor.search(string: string)
    }
}

