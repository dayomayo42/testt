//
//  ProductDetailPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 13.10.2020.
//

import Foundation
import UIKit

protocol ProductDetailPresenterProtocol: class {
    var router: ProductDetailRouterProtocol! { get set }
    func configureView(with product: Product)
    func backAction()
    func editMode(edit: Bool, product: Product)
    func delete(id: Int)
}

class ProductDetailPresenter: ProductDetailPresenterProtocol {
    var router: ProductDetailRouterProtocol!
    var interactor: ProductDetailInteractorProtocol!
    
    func configureView(with product: Product) {
        interactor.configureView(with: product)
    }
    
    func backAction() {
        router.backAction()
    }
    
    func editMode(edit: Bool, product: Product) {
        interactor.editMode(edit: edit, product: product)
    }
    
    func delete(id: Int) {
        interactor.delete(id: id)
    }
}

