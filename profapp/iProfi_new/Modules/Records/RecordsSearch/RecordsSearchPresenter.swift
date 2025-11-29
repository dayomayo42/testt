//
//  RecordsSearchPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.10.2020.
//

import Foundation
import UIKit

protocol RecordsSearchPresenterProtocol: class {
    var router: RecordsSearchRouterProtocol! { get set }
    func configureView()
    func backAction()
    func clearField()
    func showClearButton(from text: String)
    func sendRequest(string: String)
    func searchByString(string: String)
}

class RecordsSearchPresenter: RecordsSearchPresenterProtocol {
    var router: RecordsSearchRouterProtocol!
    var interactor: RecordsSearchInteractorProtocol!

    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func clearField() {
        interactor.clearField()
    }
    
    func showClearButton(from text: String) {
        interactor.showClearButton(from: text)
    }
    
    func sendRequest(string: String) {
        interactor.sendRequest(string: string)
    }
    
    func searchByString(string: String) {
        interactor.searchByString(string: string)
    }
}
