//
//  StringExtension.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 31.08.2020.
//

import Foundation

fileprivate var dateParser: DateFormatter = {
    
    let formater = DateFormatter()
    formater.locale = Locale(identifier: "en_US_POSIX")
    formater.timeZone = Date().gmt
    
    return formater
}()

extension String {
    func countryName() -> String {
        if let name = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: self) {
            // Country name was found
            return name
        } else {
            // Country name cannot be found
            return self
        }
    }
    
    func withoutSpaces() -> String {
        return self
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: " ", with: "")
    }
    
    
    func isValidPhone() -> Bool {
        let result = self.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "+", with: "")
        let regex = "^[0-9]{8}$"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", regex)
        return phoneTest.evaluate(with: result)
    }
    
    func toInt() -> Int? {
       return NumberFormatter().number(from: self)?.intValue
    }

    func convertToHours() -> Date {
        dateParser.dateFormat = "HH:mm"
       // dateFormatter.timeZone = TimeZone(abbreviation: "GMT+3:00")
        let date = dateParser.date(from: self) ?? Date()//date(from: self)
        return date
    }
    
    func convertDateToDate() -> Date {
        dateParser.dateFormat = "dd.MM.yyyy HH:mm"
       // dateFormatter.timeZone = TimeZone(abbreviation: "GMT+3:00")
        let date = dateParser.date(from: self) ?? Date()//date(from: self)
        return date
    }
    
    func convertDateToDateWTime() -> Date {
        dateParser.dateFormat = "dd.MM.yyyy"
       // dateFormatter.timeZone = TimeZone(abbreviation: "GMT+3:00")
        let date = dateParser.date(from: self) ?? Date()//date(from: self)
        return date
    }
    
    func getDateMinutes() -> Int? {
        
        dateParser.dateFormat = "HH:mm"
        
        guard let date = dateParser.date(from: self) else { return nil }
        
        var calendar = Calendar.current
        calendar.timeZone = Date().gmt
        
        var currentDateComponent = calendar.dateComponents([.hour, .minute], from: date)
        let numberOfMinutes = (currentDateComponent.hour! * 60) + currentDateComponent.minute!
        return numberOfMinutes
    }
    
    func convertDate(to type: Int) -> String {
        dateParser.dateFormat = type == 1 ? "yyyy-MM-dd" : type == 2 ? "dd.MM.yyyy" : type == 3 ? "yyyy-MM-dd HH:mm" : type == 4 ? "yyyy-MM-dd" : type == 5 ? "dd.MM.yyyy" : type == 6 ? "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX" : type == 7 ? "yyyy-MM-dd HH:mm:ss" : type == 8 ? "dd.MM.yyyy HH:mm" : "dd.MM.yyyy HH:mm"
        let date = dateParser.date(from: self) ?? Date()
        let dateFormatterTo = DateFormatter()
        dateFormatterTo.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterTo.timeZone = Date().gmt
        
        switch type {
        case 0:
            dateFormatterTo.dateFormat = "HH:mm"
        case 1:
            dateFormatterTo.dateFormat = "dd MMMM yyyy"
        case 2:
            dateFormatterTo.dateFormat = "EE"
        case 3:
            dateFormatterTo.dateFormat = "dd.MM.yyyy"
        case 4:
            dateFormatterTo.dateFormat = "dd.MM.yyyy"
        case 5:
            dateFormatterTo.dateFormat = "LLLL yyyy"
        case 6:
            dateFormatterTo.dateFormat = "dd.MM.yyyy"
        case 7:
            dateFormatterTo.dateFormat = "dd MMMM yyyy"
        case 8:
            dateFormatterTo.dateFormat = "dd.MM.yyyy"
        default:
            dateFormatterTo.dateFormat = "HH:mm, dd MMMM"
        }
        
        return dateFormatterTo.string(from: date)
    }
    
    func convertTime() -> Int {
        var times: [Int] = []
        var dateString = 0
        let cops = self.split(separator: ":")
        if cops.count > 0 {
            times.append("\(cops[0])".toInt() ?? 0)
            times.append("\(cops[1])".toInt() ?? 0)
            dateString = (times[0]*60) + times[1]
        } else {
            dateString = 0
        }
        return dateString
    }
    
    func before(first delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            let before = prefix(upTo: index)
            return String(before)
        }
        return ""
    }
    
    func after(first delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            let after = suffix(from: index).dropFirst()
            return String(after)
        }
        return ""
    }
}

extension Int {
    func getFormatedPrice() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        let str = numberFormatter.string(from: self as NSNumber) ?? ""
        return "\(str.replacingOccurrences(of: ",", with: " ")) \(Settings.currencyCym ?? "")"
    }
    
    var doubleValue: Double {
        return Double(self)
    }
}

extension String {
    func date(using format: String = "yyyy-MM-dd'T'HH:mm:ss", considerTimeZone: Bool = false) -> Date? {
        
        dateParser.dateFormat = format
        
        if considerTimeZone {
            dateParser.timeZone = TimeZone.current
        }
    
        let date = dateParser.date(from: self)
        
        if var nonnulDate = date {
            if considerTimeZone {
                nonnulDate = self.dateConsiderTimeZone(nonnulDate)
                return nonnulDate
            }
        }
        
        return date
    }
    
    private func dateConsiderTimeZone(_ date: Date) -> Date {
        var mutableDate = date
        let GMTDeltaInSeconds = TimeZone.current.secondsFromGMT()
        mutableDate = Calendar.current.date(byAdding: .second, value: GMTDeltaInSeconds, to: mutableDate)!
        return mutableDate
    }
}
