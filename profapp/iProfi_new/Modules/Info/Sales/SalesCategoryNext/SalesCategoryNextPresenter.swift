//
//  SalesCategoryNextPresenter.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation

protocol SalesCategoryNextPresenterProtocol {
    var router: SalesCategoryNextRouterProtocol! { get set }
    func configureView()
    func backAction()
    func openSales(model: SliderSales)
    func getSale(id: Int)
}

class SalesCategoryNextPresenter: SalesCategoryNextPresenterProtocol {
    var router: SalesCategoryNextRouterProtocol!
    var interactor: SalesCategoryNextInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openSales(model: SliderSales) {
        router.openSales(model: model)
    }
    
    func getSale(id: Int) {
        interactor.getSale(id: id)
    }
}
