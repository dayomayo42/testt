//
//  RecordsCalendarPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 16.11.2020.
//

import Foundation
import UIKit

protocol RecordsCalendarPresenterProtocol: class {
    var router: RecordsCalendarRouterProtocol! { get set }
    func configureView()
    func backAction()
    func selectVC(num: Int)
    func openCalendarDetail(monthCalendarDay: MonthCalendarDay, allRecords: [Records])
    func addAction()
    func getRecords(completion: @escaping () -> ())
    func addActionWithDate(_ date: String)
    func goToShitfSettings()
}

class RecordsCalendarPresenter: RecordsCalendarPresenterProtocol {
    var router: RecordsCalendarRouterProtocol!
    var interactor: RecordsCalendarInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func selectVC(num: Int) {
        interactor.selectVC(num: num)
    }
    
    func openCalendarDetail(monthCalendarDay: MonthCalendarDay, allRecords: [Records]) {
        interactor.openCalendarDetail(monthCalendarDay: monthCalendarDay, allRecords: allRecords)
    }
    
    func addAction() {
        interactor.addAction()
    }
    
    func getRecords(completion: @escaping () -> ()) {
        interactor.getRecords(completion: completion)
    }
    
    func addActionWithDate(_ date: String) {
        interactor.addActionWithDate(date)
    }
    
    func goToShitfSettings() {
        router.goToShitfSettings()
    }
}


