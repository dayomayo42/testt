//
//  RecordsCalendarMonthPresenter.swift
//  iProfi_new
//
//  Created by violy on 26.04.2023.
//

import Foundation

protocol RecordsCalendarMonthPresenterProtocol {
    var router: RecordsCalendarMonthRouterProtocol! { get set }
    func backAction()
    func configureView()
    func openCalendarDetail(monthCalendarDay: MonthCalendarDay)
    func openShedule()
}

class RecordsCalendarMonthPresenter: RecordsCalendarMonthPresenterProtocol {
    var router: RecordsCalendarMonthRouterProtocol!
    var interactor: RecordsCalendarMonthInteractorProtocol!
    
    func backAction() {
        router.backAction()
    }
    
    func configureView() {
        interactor.configureView()
    }
    
    func openCalendarDetail(monthCalendarDay: MonthCalendarDay) {
        router.openCalendarDetail(monthCalendarDay: monthCalendarDay)
    }
    
    func openShedule() {
        router.openShedule()
    }
}
