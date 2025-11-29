//
//  ProductCategoryAddPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 08.10.2020.
//

import Foundation
import UIKit

protocol ProductCategoryAddPresenterProtocol: class {
    var router: ProductCategoryAddRouterProtocol! { get set }
    func configureView()
    func backAction()
    func addAction()
}

class ProductCategoryAddPresenter: ProductCategoryAddPresenterProtocol {
    var router: ProductCategoryAddRouterProtocol!
    var interactor: ProductCategoryAddInteractorProtocol!

    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func addAction() {
        interactor.addAction()
    }
}
