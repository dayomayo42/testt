//
//  RecordsCalendarMonthRouter.swift
//  iProfi_new
//
//  Created by violy on 26.04.2023.
//

import Foundation

protocol RecordsCalendarMonthRouterProtocol {
    func backAction()
    func openCalendarDetail(monthCalendarDay: MonthCalendarDay)
    func openShedule()
}

class RecordsCalendarMonthRouter: RecordsCalendarMonthRouterProtocol {
    var viewController: RecordsCalendarMonthController!
    
    init(viewController: RecordsCalendarMonthController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func openCalendarDetail(monthCalendarDay: MonthCalendarDay) {
        let vc = viewController.getControllerRecord(controller: .calendartimes) as! CalendarTimesController
        
        vc.createDelegate = viewController.createDelegate
        vc.changeDelegate = viewController.changeDelegate
        
        vc.allRecords = viewController.records
        
        vc.monthCalendarDay = monthCalendarDay
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openShedule() {
        let vc = viewController.getControllerProfile(controller: .shedule) as! SheduleController
        
        vc.fromCreate = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
