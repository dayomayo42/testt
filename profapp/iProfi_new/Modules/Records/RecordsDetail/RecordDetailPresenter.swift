//
//  RecordDetailPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import Foundation
import UIKit

protocol RecordDetailPresenterProtocol: class {
    var router: RecordDetailRouterProtocol! { get set }
    func configureView()
    func backAction()
    func chooseClient()
    func configureView(with model: RecordCreateFillModel)
    func chooseService()
    func chooseProduct()
    func chooseNotifTime(client: Bool)
    func postRecord(model: Records)
    func editMode(edit: Bool, initMode: Bool)
    func configureView(with model: Records)
    func cancelRecord()
    func choosePhoto()
    func postPhoto(url: URL, side: Int)
    func openDate()
    
    func sharePhoto(left: String, right: String)
    func endRecord(id: Int)
    func repeateRecord()
    
    func deleteRecord()
}

class RecordDetailPresenter: RecordDetailPresenterProtocol {
    var router: RecordDetailRouterProtocol!
    var interactor: RecordDetailInteractorProtocol!
    
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
    
    func postRecord(model: Records) {
        interactor.postRecord(model: model)
    }
    
    func editMode(edit: Bool, initMode: Bool) {
        interactor.editMode(edit: edit, initMode: initMode)
    }
    
    func configureView(with model: Records) {
        interactor.configureView(with: model)
    }
    
    func cancelRecord() {
        interactor.cancelRecord()
    }
    
    func choosePhoto() {
        interactor.choosePhoto()
    }
    
    func postPhoto(url: URL, side: Int) {
        interactor.postPhoto(url: url, side: side)
    }
    
    func openDate() {
        interactor.openDate()
    }
    
    func sharePhoto(left: String, right: String) {
        interactor.sharePhoto(left: left, right: right)
    }
    
    func endRecord(id: Int) {
        interactor.endRecord(id: id)
    }
    
    func repeateRecord() {
        router.repeateRecord()
    }
    
    func deleteRecord() {
        interactor.deleteRecord()
    }
}

