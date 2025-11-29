//
//  RecordsCalendarMonthInteractor.swift
//  iProfi_new
//
//  Created by violy on 26.04.2023.
//

import Foundation
import SVProgressHUD
import Moya
import RxSwift

protocol RecordsCalendarMonthInteractorProtocol {
    func configureView()
}

class RecordsCalendarMonthInteractor: RecordsCalendarMonthInteractorProtocol {
    var viewController: RecordsCalendarMonthController!
    var presenter: RecordsCalendarMonthPresenterProtocol!
    
    let calendar = Calendar.current
    var days: [MonthCalendarDay] = []
    var records: [Records] = []
    
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: RecordsCalendarMonthController, presenter: RecordsCalendarMonthPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        guard let vc = viewController else { return }
        sortRecords()
        makeDaysList()
        
        if RecordsCalendarController.serverShadule == nil {
            getShedule()
        }
        
        if vc.sheduleDelegate != nil {
            vc.headerTitle.text = "Выходные"
            vc.plusButton.isHidden = true
        }
    }
    
    func sortRecords() {
        viewController.records = viewController.records
            .sorted { $0.date?.convertDateToDate().timeIntervalSince1970 ?? 0 < $1.date?.convertDateToDate().timeIntervalSince1970 ?? 0  }
    }
    
    private func getDateRecords(date: Date?) -> [Records] {
        guard let date else { return [] }
        
        var returnResult: [Records] = []
        let records = viewController.records
        let dateStr = date.getDate()
        
        records.forEach { record in
            if let date = record.date {
                if date.contains(dateStr) {
                    returnResult.append(record)
                }
            }
        }
        
        return returnResult
    }
    
    func makeDaysList() {
        
        let stopDate = Date().getCurrentGmtDate().calendarEndDate()

        var currentCalendar = Calendar.current
        currentCalendar.timeZone = Date().gmt
       
        let calendarComponents = DateComponents(hour: 0, minute: 0, second: 0, nanosecond: 0)
        
        
        currentCalendar.enumerateDates(startingAfter: "2020-01-01T00:00:00".date()!, matching: calendarComponents, matchingPolicy: .nextTimePreservingSmallerComponents, repeatedTimePolicy: .first, direction: .forward) { date, _, stop in
            if let date = date {
                if date > stopDate.dateWithDayEnd() {
                    stop = true
                } else {
                    if date == date.endOfMonth() {
                        days.append(MonthCalendarDay(date: date, number: date.getDay(), weekdayNumber: date.numberOfDayInWeek(), endOfMonth: true))
                    } else if date == date.startOfMonth() {
                        days.append(MonthCalendarDay(date: date, number: date.getDay(), weekdayNumber: date.numberOfDayInWeek(), startOfMonth: true))
                    } else {
                        days.append(MonthCalendarDay(date: date, number: date.getDay(), weekdayNumber: date.numberOfDayInWeek()))
                    }
                }
            }
        }
        
        makeDatasource(with: days)
    }
    
    func makeDatasource(with daysList: [MonthCalendarDay]) {
        
        let weekends = viewController.sheduleDelegate?.sheduleModel.weekends
        
        var dateItems = [MonthCalendarItem]()
        for date in daysList {
            
            if date.date == date.date?.startOfMonth() {
                dateItems.append(.month(date.date?.stringDateWithFormat(format: "LLLL yyy") ?? ""))
                dateItems.append(.weekDay("Пн"))
                dateItems.append(.weekDay("Вт"))
                dateItems.append(.weekDay("Ср"))
                dateItems.append(.weekDay("Чт"))
                dateItems.append(.weekDay("Пт"))
                dateItems.append(.weekDay("Сб"))
                dateItems.append(.weekDay("Вс"))
                if date.date?.numberOfDayInWeek() == 1 {
                    let records = getDateRecords(date: date.date)
                    dateItems.append(.monthDay(MonthCalendarDay(date: date.date, number: date.number, weekdayNumber: date.weekdayNumber, startOfMonth: date.startOfMonth, endOfMonth: date.endOfMonth, records: records, isWeekend: weekends?.contains(date.date?.getDate() ?? "") ?? nil)))
                } else {
                    dateItems.append(contentsOf: getEmptyDays(count: ((date.date?.numberOfDayInWeek() ?? 0) - 1)))
                    let records = getDateRecords(date: date.date)
                    dateItems.append(.monthDay(MonthCalendarDay(date: date.date, number: date.number, weekdayNumber: date.weekdayNumber, startOfMonth: date.startOfMonth, endOfMonth: date.endOfMonth, records: records, isWeekend: weekends?.contains(date.date?.getDate() ?? "") ?? nil)))
                }
            } else {
                if date.date == date.date?.endOfMonth() {
                    if date.date?.numberOfDayInWeek() == 7 {
                        let records = getDateRecords(date: date.date)
                        dateItems.append(.monthDay(MonthCalendarDay(date: date.date, number: date.number, weekdayNumber: date.weekdayNumber, startOfMonth: date.startOfMonth, endOfMonth: date.endOfMonth, records: records, isWeekend: weekends?.contains(date.date?.getDate() ?? "") ?? nil)))
                    } else {
                        let records = getDateRecords(date: date.date)
                        dateItems.append(.monthDay(MonthCalendarDay(date: date.date, number: date.number, weekdayNumber: date.weekdayNumber, startOfMonth: date.startOfMonth, endOfMonth: date.endOfMonth, records: records, isWeekend: weekends?.contains(date.date?.getDate() ?? "") ?? nil)))
                        dateItems.append(contentsOf: getEmptyDays(count: (7 - (date.date?.numberOfDayInWeek() ?? 0))))
                    }
                } else {
                    let records = getDateRecords(date: date.date)
                    dateItems.append(.monthDay(MonthCalendarDay(date: date.date, number: date.number, weekdayNumber: date.weekdayNumber, startOfMonth: date.startOfMonth, endOfMonth: date.endOfMonth, records: records, isWeekend: weekends?.contains(date.date?.getDate() ?? "") ?? nil)))
                }
            }
        }
        
        viewController.calendarItems = dateItems
    }
    
    func getEmptyDays(count: Int) -> [MonthCalendarItem] {
        var days: [MonthCalendarItem] = []
        for _ in 0..<count {
            days.append(.empty)
        }
        return days
    }

    func getShedule() {
        SVProgressHUD.show()
        service.getCalendarTimes().subscribe { response in
            SVProgressHUD.dismiss()
            if response.success ?? false {
                RecordsCalendarController.serverShadule = response.data
            } else {
                SVProgressHUD.showError(withStatus: response.message)
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}

