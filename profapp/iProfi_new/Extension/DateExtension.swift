//
//  DateExtension.swift
//  iProfi_new
//
//  Created by violy on 26.04.2023.
//

import Foundation

extension Date {
    private var timeIntervalToDayEnd: TimeInterval { 60*60*23 + 60*58 }
    
    func shortDate() -> Date {
        let dateFormatter = formatterWithFormat(format: "dd MMM yyy")
        return dateFormatter.date(from: dateFormatter.string(from: self)) ?? Date().getCurrentGmtDate()
    }
    
    // Строчка времени без даты в формате HH:mm
    func shortTimeString() -> String {
        let dateFormatter = formatterWithFormat(format: "HH:mm")
        return dateFormatter.string(from: self)
    }
    
    // Дата с добавлением времени до конца дня
    func dateWithDayEnd() -> Date {
        let dateFormatter = formatterWithFormat(format: "dd MMM yyy")
        return dateFormatter.date(from: dateFormatter.string(from: self))?.addingTimeInterval(timeIntervalToDayEnd) ?? Date().getCurrentGmtDate()
    }
    
    func stringDateWithFormat(format : String) -> String {
        return formatterWithFormat(format: format).string(from: self).capitalized
    }
    
    func stringDateWithFormatUsingCurrentTimeZone(format: String) -> String {
        return formatterWithFormatForCurrentTimeZone(format: format).string(from: self)
    }
    
    func stringDateWithFormatUTC(format : String) -> String {
        
        let formatter = formatterWithFormat(format: format)
        formatter.timeZone = TimeZone(identifier: "GMT")
        
        return formatter.string(from: self)
    }
    
    func string(using format : String, isPosixLocale: Bool = false) -> String {
        return formatterWithFormat(format: format, isPosixLocale: isPosixLocale).string(from: self)
    }
 
    func dateWithoutTime(forceLocalTimeZone: Bool = false) -> Date {
        
        let dateFormatter = formatterWithFormat(format: "yyyy-MM-dd")
    
        if forceLocalTimeZone {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.locale = Locale(identifier: "ru_RU")
        }
       
        
        let string = dateFormatter.string(from: self)
        
        return dateFormatter.date(from: string) ?? Date().getCurrentGmtDate()
    }
    
    func isFuture() -> Bool {
        
        let currentDateStr = Date().getCurrentGmtDate().stringDateWithFormat(format: "yyyy-MM-dd'T'HH:mm:ss")
        let currentDate = currentDateStr.date(using: "yyyy-MM-dd'T'HH:mm:ss", considerTimeZone: true) ?? Date().getCurrentGmtDate()
        
        return self.compare(currentDate) == .orderedDescending
    }
    
    static var beforeYesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -2, to: Date().getCurrentGmtDate().noon) ?? Date().getCurrentGmtDate()
    }
    
    static var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date().getCurrentGmtDate()) ?? Date().getCurrentGmtDate()
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self) ?? Date().getCurrentGmtDate()
    }
    
    private static var dateFormatter: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        return dateFormatter
    }()
    
    private func formatterWithFormat(format: String, isPosixLocale: Bool = false) -> DateFormatter {
        
        Self.dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        Self.dateFormatter.dateFormat = format
        Self.dateFormatter.locale = isPosixLocale ? Locale(identifier: "en_US_POSIX") : Locale(identifier: "ru_RU")
        
        return Self.dateFormatter
    }
    
    private func formatterWithFormatForCurrentTimeZone(format: String, isPosixLocale: Bool = false) -> DateFormatter {
        
        Self.dateFormatter.timeZone = TimeZone.current
        Self.dateFormatter.dateFormat = format
        Self.dateFormatter.locale = isPosixLocale ? Locale(identifier: "en_US_POSIX") : Locale(identifier: "ru_RU")
        
        return Self.dateFormatter
    }
    
}

fileprivate var dateParser: DateFormatter = {
    
    let formater = DateFormatter()
    formater.locale = Locale(identifier: "en_US_POSIX")
    formater.timeZone = Date().gmt
    
    return formater
}()

extension Date {
    
    
    var gmt: TimeZone { TimeZone(identifier:"GMT")! }
    
    // Получить год 
    func getYear() -> Int {
        var calendar = Calendar.current
        calendar.timeZone = gmt
        return calendar.component(.year, from: self)
    }
    
    // Начало недели (для недельного календаря)
    func startOfWeek() -> Date {
        var calendar = Calendar.current
        var components = calendar.dateComponents([ .yearForWeekOfYear, .weekOfYear], from: self)
        components.weekday = calendar.firstWeekday
        return calendar.date(from: components)!
    }
    
    // Начальная дата месяца
    func startOfMonth() -> Date {
        var calendar = Calendar.current
        calendar.timeZone = gmt
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)!
    }
    
    // Дата на год назад от текущей
    func calendarStartDate() -> Date {
        var calendar = Calendar.current
        calendar.timeZone = gmt
        let newDate = calendar.date(byAdding: .year, value: -1, to: Date())!
        return newDate.startOfMonth()
    }
    
    // Дата на год вперед от текущей
    func calendarEndDate() -> Date {
        var calendar = Calendar.current
        calendar.timeZone = gmt
        
        let newDate = calendar.date(byAdding: .year, value: 2, to: Date())!
        let year = calendar.component(.year, from: newDate)
        
        if let firstOfNextYear = calendar.date(from: DateComponents(year: year + 1, month: 1, day: 1)) {
            let lastOfYear = calendar.date(byAdding: .day, value: -1, to: firstOfNextYear) ?? Date()
            
            return lastOfYear
        } else {
            return newDate.endOfMonth()
        }
    }

    // Конечная дата месяца
    func endOfMonth() -> Date {
        var calendar = Calendar.current
        calendar.timeZone = gmt
        return calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth())!
    }
    
    // Получение дня
    func getDay() -> String {
        var calendar = Calendar.current
        calendar.timeZone = gmt
        let component = calendar.dateComponents(in: gmt, from: self)
        return String(component.day ?? 0)
    }

    // Номер дня в недели
    func numberOfDayInWeek() -> Int {
        var customCalendar = Calendar(identifier: .iso8601)
        customCalendar.firstWeekday = 2
        let num = (customCalendar.dateComponents(in: gmt, from: self).weekday ?? 0) - 1
        return num == 0 ? 7 : num
    }
    
    // Является ли день текущим
    func isToday() -> Bool {
        var calendar = Calendar.current
        calendar.timeZone = gmt
        return calendar.isDateInToday(self)
    }
    
    // Входит ли день в актуальную неделю
    func isDayInCurrentWeek() -> Bool {
        var calendar = Calendar.current
        calendar.timeZone = gmt
        return calendar.isDate(self, equalTo: Date().localDate(), toGranularity: .weekOfYear)
    }
    
    // Получить дату в стринге
    func getDate() -> String {
        dateParser.dateFormat = "dd.MM.yyyy"
        return dateParser.string(from: self)
    }
    
    // Получить время в стринге
    func getTime() -> String {
        dateParser.locale = Locale(identifier: "en_US_POSIX")
        dateParser.dateFormat = "HH:mm"
        
        return dateParser.string(from: self)
    }
    
    // Получить месяц в стриге
    func getMonth() -> String {
        dateParser.dateFormat = "MM"
        return dateParser.string(from: self)
    }
    
    func getMinutesOfDate() -> Int {
        var calendar = Calendar.current
        calendar.timeZone = gmt
        
        var currentDateComponent = calendar.dateComponents([.hour, .minute], from: self)
        let numberOfMinutes = (currentDateComponent.hour! * 60) + currentDateComponent.minute!
        return numberOfMinutes
    }
    
    func getWeekNameShortString() -> String {
        var calendar = Calendar.current
        calendar.timeZone = gmt
        let weekIndex = calendar.component(.weekday, from: self)
        switch weekIndex {
        case 1:
            return "Вс"
        case 2:
            return "Пн"
        case 3:
            return "Вт"
        case 4:
            return "Ср"
        case 5:
            return "Чт"
        case 6:
            return "Пт"
        case 7:
            return "Сб"
        default:
            return ""
        }
    }
    
    func getMonthString(short: Bool = false) -> String {
        var calendar = Calendar.current
        calendar.timeZone = gmt
        let monthIndex = calendar.component(.month, from: self)
        switch monthIndex {
        case 1:
            return short ? "Янв" : "Январь"
        case 2:
            return short ? "Февр" : "Февраль"
        case 3:
            return "Март"
        case 4:
            return short ? "Апр" : "Апрель"
        case 5:
            return "Май"
        case 6:
            return "Июнь"
        case 7:
            return "Июль"
        case 8:
            return short ? "Авг" : "Август"
        case 9:
            return short ? "Сент" : "Сентябрь"
        case 10:
            return short ? "Окт" : "Октябрь"
        case 11:
            return short ? "Нояб" : "Ноябрь"
        case 12:
            return short ? "Дек" : "Декабрь"
        default:
            return ""
        }
    }
}


/// Локальная дата. Корректно работает в том числе и ночью
extension Date {
    func localDate() -> Date {
        let nowUTC = self
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}

        return localDate
    }
}
