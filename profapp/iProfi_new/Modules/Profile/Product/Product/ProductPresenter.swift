//
//  ProductPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 07.10.2020.
//

import Foundation
import UIKit

protocol ProductPresenterProtocol: class {
    var router: ProductRouterProtocol! { get set }
    func configureView()
    func openCategory(category: Category)
    func addCategory()
    func backAction()
    func getCategories()
}

class ProductPresenter: ProductPresenterProtocol {
    var router: ProductRouterProtocol!
    var interactor: ProductInteractorProtocol!

    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openCategory(category: Category) {
        interactor.openCategory(category: category)
    }
    
    func addCategory() {
        interactor.addCategory()
    }
    
    func getCategories() {
        interactor.getCategories()
    }
}
