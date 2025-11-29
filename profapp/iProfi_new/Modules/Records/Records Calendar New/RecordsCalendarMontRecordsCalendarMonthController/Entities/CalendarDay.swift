//
//  CalendarDay.swift
//  iProfi_new
//
//  Created by violy on 26.04.2023.
//

import Foundation

enum MonthCalendarItem {
    case monthDay(MonthCalendarDay)
    case month(String)
    case weekDay(String)
    case empty
}

// Модель дня календаря
struct MonthCalendarDay {
    
    // Дата
    let date: Date?
    
    // День
    let number: String?
    
    // Номер дня недели
    let weekdayNumber: Int?
    
    // Начало месяца
    var startOfMonth: Bool = false
    
    // Конец месяца
    var endOfMonth: Bool = false
    
    // Записи на день
    var records: [Records]?
    
    // Является ли выходным днем
    var isWeekend: Bool? = nil
    
    // Рассписание
    var sheduleString: [String] = []
}
