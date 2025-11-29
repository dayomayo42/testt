//
//  StockProductDetailPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 09.11.2020.
//

import Foundation
import UIKit

protocol StockProductDetailPresenterProtocol: class {
    var router: StockProductDetailRouterProtocol! { get set }
    func configureView()
    func backAction()
    func checkField()
    func chooseSupplier()
    func postEditModel()
    func choosePhoto()
    func editAction(isEdit: Bool)
    func deleteAction()
    func fillView(with model: StockProduct)
}

class StockProductDetailPresenter: StockProductDetailPresenterProtocol {
    var router: StockProductDetailRouterProtocol!
    var interactor: StockProductDetailInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func checkField() {
        interactor.checkField()
    }
    
    func chooseSupplier() {
        interactor.chooseSupplier()
    }
    
    func postEditModel() {
        interactor.postProduct()
    }
    
    func choosePhoto() {
        interactor.choosePhoto()
    }
    
    func editAction(isEdit: Bool) {
        interactor.editAction(isEdit: isEdit)
    }
    
    func deleteAction() {
        interactor.deleteAction()
    }
    
    func fillView(with model: StockProduct) {
        interactor.fillView(with: model)
    }
}
