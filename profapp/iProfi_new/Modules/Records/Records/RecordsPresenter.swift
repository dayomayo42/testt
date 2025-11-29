//
//  RecordsPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import Foundation
import UIKit

protocol RecordsPresenterProtocol: class {
    var router: RecordsRouterProtocol! { get set }
    func configureView()
    func createAction()
    func openSearch()
    func getRecords()
    func openDetail(with model: Records, type: RecordsType)
    func openCalendar()
    func openSubExpiredView()
}

class RecordsPresenter: RecordsPresenterProtocol {
    var router: RecordsRouterProtocol!
    var interactor: RecordsInteractorProtocol!

    func configureView() {
        interactor.configureView()
    }
    
    func createAction() {
        interactor.createRecord()
    }
    
    func openSearch() {
        interactor.openSearch()
    }
    
    func getRecords() {
        interactor.getRecords()
    }
    
    func openDetail(with model: Records, type: RecordsType) {
        interactor.openDetail(with: model, type: type)
    }
    
    func openCalendar() {
        interactor.openCalendar()
    }
    
    func openSubExpiredView() {
        router.openSubExpiredView()
    }
}
