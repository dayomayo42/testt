//
//  StockConsumptionPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.12.2020.
//

import Foundation
import UIKit

protocol StockConsumptionPresenterProtocol: class {
    var router: StockConsumptionRouterProtocol! { get set }
    func configureView()
    func backAction()
    func addClient()
    func addProduct()
    func updateDatas()
    func checkFields()
    func fillStack()
    func clearFields()
    func clearStack()
    func sendArrival(model: StockConsumptionModel)
}

class StockConsumptionPresenter: StockConsumptionPresenterProtocol {
    var router: StockConsumptionRouterProtocol!
    var interactor: StockConsumptionInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func addClient(){
        interactor.addClient()
    }
    
    func addProduct() {
        interactor.addProduct()
    }
    
    func updateDatas() {
        interactor.updateDatas()
    }
    
    
    func checkFields() {
        interactor.checkFields()
    }
    
    func fillStack() {
        interactor.fillStack()
    }
    
    func clearFields() {
        interactor.clearFields()
    }
    
    func clearStack() {
        interactor.clearStack()
    }
    
    func sendArrival(model: StockConsumptionModel) {
        interactor.sendArrival(model: model)
    }
}


