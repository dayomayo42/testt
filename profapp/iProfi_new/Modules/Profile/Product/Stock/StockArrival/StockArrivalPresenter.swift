//
//  StockArrivalPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.12.2020.
//

import Foundation
import UIKit

protocol StockArrivalPresenterProtocol: class {
    var router: StockArrivalRouterProtocol! { get set }
    func configureView()
    func backAction()
    func addDealer()
    func addProduct()
    func updateDatas()
    func checkFields()
    func fillStack()
    func clearFields()
    func clearStack()
    func sendArrival(model: StockArrivalModel)
}

class StockArrivalPresenter: StockArrivalPresenterProtocol {
    var router: StockArrivalRouterProtocol!
    var interactor: StockArrivalInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func addDealer() {
        interactor.addDealer()
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
    
    func sendArrival(model: StockArrivalModel) {
        interactor.sendArrival(model: model)
    }
}


