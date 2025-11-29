//
//  SaleDistributorsPresenter.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation

protocol SalesDistributorsPresenterProtocol {
    var router: SalesDistributorsRouterProtocol! { get set }
    func configureView()
    func backAction()
    func openSalesCategoryNext(model: SliderModelSales)
    func getSalesByDistributors(id: Int)
}

class SalesDistributorsPresenter: SalesDistributorsPresenterProtocol {
    var router: SalesDistributorsRouterProtocol!
    var interactor: SalesDistributorsInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openSalesCategoryNext(model: SliderModelSales) {
        router.openSalesCategoryNext(model: model)
    }
    
    func getSalesByDistributors(id: Int) {
        interactor.getSalesByDistributors(id: id)
    }
}
