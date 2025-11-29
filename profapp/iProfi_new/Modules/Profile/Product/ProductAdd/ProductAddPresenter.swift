//
//  ProductDetailPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 12.10.2020.
//

import Foundation
import UIKit

protocol ProductAddPresenterProtocol: class {
    var router: ProductAddRouterProtocol! { get set }
    func configureView()
    func backAction()
    func checkFields(pos: Int, str: String)
    func addProduct(model: ProductCreateModel)
}

class ProductAddPresenter: ProductAddPresenterProtocol {
    var router: ProductAddRouterProtocol!
    var interactor: ProductAddInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func checkFields(pos: Int, str: String) {
        interactor.checkFields(pos: pos, str: str)
    }
    
    func addProduct(model: ProductCreateModel) {
        interactor.addProduct(model: model)
    }
}

