//
//  StockProductAddPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.11.2020.
//

import Foundation
import UIKit

protocol StockProductAddPresenterProtocol: class {
    var router: StockProductAddRouterProtocol! { get set }
    func configureView()
    func backAction()
    func checkField()
    func chooseSupplier()
    func postProduct()
    func choosePhoto()
}

class StockProductAddPresenter: StockProductAddPresenterProtocol {
    var router: StockProductAddRouterProtocol!
    var interactor: StockProductAddInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func checkField() {
        interactor.checkField()
    }
    
    func chooseSupplier() {
        interactor.chooseSupplier()
    }
    
    func postProduct() {
        interactor.postProduct()
    }
    
    func choosePhoto() {
        interactor.choosePhoto()
    }
}

