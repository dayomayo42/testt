//
//  WeekDayCalendar.swift
//  iProfi_new
//
//  Created by violy on 18.05.2023.
//

import Foundation

struct WeekDayCalendar {
    
    // Дата
    let date: Date?
    
    // День
    let number: String?
    
    // Номер дня недели
    let weekdayNumber: Int?
    
    // Записи на день
    var records: [Records]?
}
