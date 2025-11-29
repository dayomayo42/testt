//
//  SalesCategoryPresenter.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation

protocol SalesCategoryPresenterProtocol {
    var router: SalesCategoryRouterProtocol! { get set }
    func configureView()
    func backAction()
    func openSalesCategoryNext(model: SliderModelSales, categoryName: String)
    func getSalesByCategory(id: Int, completion: @escaping (SliderModelSales) -> ())
}

class SalesCategoryPresenter: SalesCategoryPresenterProtocol {
    var router: SalesCategoryRouterProtocol!
    var interactor: SalesCategoryInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openSalesCategoryNext(model: SliderModelSales, categoryName: String) {
        router.openSalesCategoryNext(model: model, categoryName: categoryName)
    }
    
    func getSalesByCategory(id: Int, completion: @escaping (SliderModelSales) -> ()) {
        interactor.getSalesByCategory(id: id, completion: completion)
    }
}
