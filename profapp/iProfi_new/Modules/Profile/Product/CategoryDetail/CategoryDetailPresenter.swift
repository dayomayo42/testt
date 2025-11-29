//
//  CatgoryDetailPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 12.10.2020.
//

import Foundation
import UIKit

protocol CategoryDetailPresenterProtocol: class {
    var router: CategoryDetailRouterProtocol! { get set }
    func configureView()
    func backAction()
    func addProduct(category: Category)
    func openDetail(with product: Product)
    func getProduct(category id: Int)
    func deleteCategory(category id: Int)
}

class CategoryDetailPresenter: CategoryDetailPresenterProtocol {
    var router: CategoryDetailRouterProtocol!
    var interactor: CategoryDetailInteractorProtocol!

    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func addProduct(category: Category) {
        interactor.addProduct(category: category)
    }
    
    func openDetail(with product: Product) {
        interactor.openDetail(with: product)
    }
    
    func getProduct(category id: Int) {
        interactor.getProduct(category: id)
    }
    
    func deleteCategory(category id: Int) {
        interactor.deleteCategory(category: id)
    }
}
