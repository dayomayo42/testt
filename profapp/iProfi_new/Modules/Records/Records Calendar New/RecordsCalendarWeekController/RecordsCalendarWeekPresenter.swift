//
//  RecordsCalendarWeekPresenter.swift
//  iProfi_new
//
//  Created by violy on 12.05.2023.
//

import Foundation

protocol RecordsCalendarWeekPresenterProtocol {
    var router: RecordsCalendarWeekRouterProtocol! { get set }
    func configureView()
    func backAction()
}

class RecordsCalendarWeekPresenter: RecordsCalendarWeekPresenterProtocol {
    
    var router: RecordsCalendarWeekRouterProtocol!
    var interactor: RecordsCalendarWeekInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
}
