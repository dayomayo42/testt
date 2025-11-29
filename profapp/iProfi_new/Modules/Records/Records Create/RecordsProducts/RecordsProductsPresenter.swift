//
//  RecordsProductsPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 26.10.2020.
//

import Foundation
import UIKit

protocol RecordsProductsPresenterProtocol: class {
    var router: RecordsProductsRouterProtocol! { get set }
    func configureView()
    func backAction()
    func checkCacheProducts()
    func getProduct()
    func chooseProduct()
    func addProduct()
    func search(string: String)
    func chooseNoProduct()
}

class RecordsProductsPresenter: RecordsProductsPresenterProtocol {
    var router: RecordsProductsRouterProtocol!
    var interactor: RecordsProductsInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func checkCacheProducts() {
        interactor.checkCacheProducts()
    }
    
    func getProduct() {
        interactor.getProduct()
    }
    
    func chooseProduct() {
        interactor.chooseProduct()
    }
    
    func addProduct() {
        interactor.addProduct()
    }
    
    func search(string: String) {
        interactor.search(string: string)
    }
    
    func chooseNoProduct() {
        interactor.chooseNoProduct()
    }
}

