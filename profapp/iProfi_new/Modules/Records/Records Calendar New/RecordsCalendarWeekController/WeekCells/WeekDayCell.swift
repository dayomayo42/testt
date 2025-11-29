//
//  WeekDayCell.swift
//  iProfi_new
//
//  Created by violy on 17.05.2023.
//

import Foundation
import UIKit

class WeekDayCell: UICollectionViewCell {
    @IBOutlet weak var stackView: UIStackView!
    
    var dayModel: WeekDayCalendar? = nil
    var delegate: RecordsCalendarWeekDelegate?
    
    func configure(model: WeekDayCalendar) {
        self.dayModel = model
        drawButtons()
    }
    
    func drawButtons() {
        guard let dayModel, let records = dayModel.records else { return }
        
        self.subviews.forEach { subview in
            if subview.tag == 42 {
                subview.removeFromSuperview()
            }
        }
        
        records.forEach({ record in
            if let duration = record.duration, let date = record.date {
                if let minutes = String(date.suffix(5)).getDateMinutes() {
                    
                    let button = WeekCalendarRecordButton(frame: CGRect(x: 1, y: minutes*2, width: Int(self.frame.width-1), height: duration*2))
                    
                    button.cornerRadiusV = 4
                    button.borderWidthV = 1
                    button.borderColorV = UIColor.white
                    
                    button.backgroundColor = getStatusColor(item: record).0
                    button.type = getStatusColor(item: record).1
                    button.record = record
                    button.tag = 42
                    button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                    
                    self.addSubview(button)
                }
            }
        })
    }
    
    func getStatusColor(item: Records) -> (UIColor, RecordsType) {
        let current = Date().getCurrentGmtDate()
        
        var returnColor: UIColor = .clear
        var returnType: RecordsType = .future
        
        if item.date?.convertDateToDate().timeIntervalSince1970 ?? 0 > current.timeIntervalSince1970 {
            returnColor = #colorLiteral(red: 0, green: 0.4347205758, blue: 0.9958539605, alpha:  1) //будет
            returnType = .future
            if item.status == 1 {
                returnColor = #colorLiteral(red: 0.9677701592, green: 0.230127275, blue: 0.2682518363, alpha: 1) //отменено
                returnType = .cancelled
            }
        } else if Int(current.timeIntervalSince1970 - (item.date?.convertDateToDate().timeIntervalSince1970 ?? 0)) < (item.duration ?? 0)*60 {
            if item.status == 0 {
                returnColor = #colorLiteral(red: 1, green: 0.796792984, blue: 0, alpha: 1) //в процессе
                returnType = .now
            } else if item.status == 1 {
                returnColor = #colorLiteral(red: 0.9677701592, green: 0.230127275, blue: 0.2682518363, alpha: 1) //отменено
                returnType = .cancelled
            }
        } else {
            returnColor = #colorLiteral(red: 0, green: 0.8690080047, blue: 0.3919513524, alpha: 1)  //завершено
            returnType = .ended
            if item.status == 1 {
                returnColor = #colorLiteral(red: 0.9677701592, green: 0.230127275, blue: 0.2682518363, alpha: 1)
                returnType = .cancelled
            }
        }
        return (returnColor, returnType)
    }
    
    @objc
    fileprivate func buttonAction(sender: WeekCalendarRecordButton!) {
        guard let record = sender.record, let type = sender.type else { return }
        delegate?.openRecord(record: record, type: type)
    }
}

fileprivate class WeekCalendarRecordButton : UIButton {
    var record: Records?
    var type: RecordsType?
}
