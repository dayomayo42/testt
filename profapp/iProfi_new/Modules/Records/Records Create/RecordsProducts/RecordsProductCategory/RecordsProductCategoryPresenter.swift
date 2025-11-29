//
//  RecordsProductCategoryPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 18.01.2021.
//

import Foundation
import UIKit

protocol RecordsProductCategoryPresenterProtocol: class {
    var router: RecordsProductCategoryRouterProtocol! { get set }
    func configureView()
    func backAction()
    
    func openCategory(category: Category)
    func addCategory()
    func getCategories()
}

class RecordsProductCategoryPresenter: RecordsProductCategoryPresenterProtocol {
    var router: RecordsProductCategoryRouterProtocol!
    var interactor: RecordsProductCategoryInteractorProtocol!
    
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


