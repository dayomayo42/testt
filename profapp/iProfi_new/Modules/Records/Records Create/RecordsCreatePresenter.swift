//
//  RecordsCreatePresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.10.2020.
//

import Foundation
import UIKit

protocol RecordsCreatePresenterProtocol: class {
    var router: RecordsCreateRouterProtocol! { get set }
    func configureView()
    func backAction()
    func chooseClient()
    func configureView(with model: RecordCreateFillModel)
    func chooseService()
    func chooseProduct()
    func chooseNotifTime(client: Bool)
    func postRecord(model: CreateRecordModel)
    func checkAndPost(model: CreateRecordModel)
    func checkFill()
    func openDate()
}

class RecordsCreatePresenter: RecordsCreatePresenterProtocol {
    var router: RecordsCreateRouterProtocol!
    var interactor: RecordsCreateInteractorProtocol!

    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func chooseClient() {
        router.chooseClient()
    }
    
    func configureView(with model: RecordCreateFillModel) {
        interactor.configureView(with: model)
    }
    
    func chooseService() {
        router.chooseService()
    }
    
    func chooseProduct() {
        router.chooseProduct()
    }
    
    func chooseNotifTime(client: Bool) {
        interactor.chooseNotifTime(client: client)
    }
    
    func postRecord(model: CreateRecordModel) {
        interactor.postRecord(model: model)
    }
    
    func checkFill() {
        interactor.checkFill()
    }
    
    func openDate() {
        router.openDate()
    }
    
    func checkAndPost(model: CreateRecordModel) {
        interactor.checkAndPost(model: model)
    }
}
