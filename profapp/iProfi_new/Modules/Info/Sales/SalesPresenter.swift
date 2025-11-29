//
//  SalesPresenter.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation

protocol SalesPresenterProtocol {
    var router: SalesRouterProtocol! { get set }
    func configureView()
    func backAction()
    func initSlider(with slides: SliderModel)
    func openSalesCategory(model: SaleCategoryModel)
    func openSalesDistributors(model: DistributorsModel)
    func openFavouriteDetail()
    func getDistributors()
    func openSale(model: SliderSales)
    func getFavorites()
    func getSalesCategories()
    func getSale(id: Int)
    func getSalesByDistributors(id: Int, completion: @escaping (SliderModelSales) -> ())
    func openDistibutor(model: SliderModelSales, categoryName: String)
}

class SalesPresenter: SalesPresenterProtocol {
    var router: SalesRouterProtocol!
    var interactor: SalesInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func initSlider(with slides: SliderModel) {
        interactor.initSlider(with: slides)
    }
    
    func getDistributors() {
        interactor.getDistributors()
    }
    
    func openSalesCategory(model: SaleCategoryModel) {
        router.openSalesCategory(model: model)
    }
    
    func openSalesDistributors(model: DistributorsModel) {
        router.openSalesDistributors(model: model)
    }
    
    func getSale(id: Int) {
        interactor.getSale(id: id)
    }
    
    func openFavouriteDetail() {
        router.openFavouriteDetail()
    }
    
    func openSale(model: SliderSales) {
        router.openSale(model: model)
    }
    
    func getFavorites() {
        interactor.getFavorites()
    }
    
    func getSalesCategories() {
        interactor.getSalesCategories()
    }
    
    func getSalesByDistributors(id: Int, completion: @escaping (SliderModelSales) -> ()) {
        interactor.getSalesByDistributors(id: id, completion: completion)
    }
    
    func openDistibutor(model: SliderModelSales, categoryName: String) {
        router.openDistibutor(model: model, categoryName: categoryName)
    }
}
