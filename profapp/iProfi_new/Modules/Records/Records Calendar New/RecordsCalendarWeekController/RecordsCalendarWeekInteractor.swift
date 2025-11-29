//
//  RecordsCalendarWeekInteractor.swift
//  iProfi_new
//
//  Created by violy on 12.05.2023.
//

import Foundation

protocol RecordsCalendarWeekInteractorProtocol {
    func configureView()
}

class RecordsCalendarWeekInteractor: RecordsCalendarWeekInteractorProtocol {
    var viewController: RecordsCalendarWeekViewController!
    var presenter: RecordsCalendarWeekPresenterProtocol!
    
    init(viewController: RecordsCalendarWeekViewController, presenter: RecordsCalendarWeekPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    let calendar = Calendar.current
    var calendarItems: [[WeekDayCalendar]] = []
    
    func configureView() {
        makeDaysList()
    }
    
    func makeDaysList() {
        
        self.calendarItems.removeAll()
        
        let stopDate = Date().getCurrentGmtDate().calendarEndDate()
        
        var calendarItem: [WeekDayCalendar] = []

        var currentCalendar = Calendar.current
        currentCalendar.timeZone = Date().gmt
       
        let calendarComponents = DateComponents(hour: 0, minute: 0, second: 0, nanosecond: 0)
        
        currentCalendar.enumerateDates(startingAfter: "2020-01-01T00:00:00".date()!.startOfWeek(), matching: calendarComponents, matchingPolicy: .nextTimePreservingSmallerComponents, repeatedTimePolicy: .first, direction: .forward) { date, _, stop in
            
            if let date = date {
                if date > stopDate.dateWithDayEnd() {
                    stop = true
                } else {
                    let records = getDateRecords(date: date)
                    calendarItem.append(WeekDayCalendar(date: date, number: date.getDay(), weekdayNumber: date.numberOfDayInWeek(), records: records))
                    
                    if date.numberOfDayInWeek() == 7 {
                        calendarItems.append(calendarItem)
                        calendarItem = []
                    }
                }
            }
        }
        
        viewController.calendarItems = calendarItems
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
}
