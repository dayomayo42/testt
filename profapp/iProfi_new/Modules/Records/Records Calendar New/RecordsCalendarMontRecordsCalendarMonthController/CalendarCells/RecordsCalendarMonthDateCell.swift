//
//  RecordsCalendarMonthDateCell.swift
//  iProfi_new
//
//  Created by violy on 26.04.2023.
//

import Foundation
import UIKit

class RecordsCalendarMonthDateCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var eventCountLabel: UILabel!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var backView: UIView!
    
    private var calendar = Calendar.current
    
    override var isSelected: Bool {
        didSet {
            guard isWeekend != nil else { return }
            if isSelected {
                UIView.animate(withDuration: 0.3) {
                    self.dateLabel.textColor = .white
                    self.circleView.alpha = 1
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.dateLabel.textColor = .black
                    self.circleView.alpha = 0
                }
            }
        }
    }
    
    var isWeekend: Bool?
    
    func configure(model: MonthCalendarDay) {
        
        guard let date = model.date else { return }
        
        dateLabel.text = model.number
        
        if let recordsCount = model.records?.count {
            eventCountLabel.text = recordsCount > 0 ? "x\(model.records!.count)" : nil
        } else {
            eventCountLabel.text = nil
        }
        
        if model.isWeekend == nil {
            circleView.alpha = !date.isToday() ? 0 : 1
            dateLabel.textColor = date.isToday() ? .white : .black
        }
        
        isWeekend = model.isWeekend
        
        eventCountLabel.isHidden = eventCountLabel.text?.isEmpty ?? true
        backView.backgroundColor = date.isDayInCurrentWeek() ? UIColor(named: "appLightBlue") : .clear
        
        guard date.isDayInCurrentWeek() else { return }
        
        if model.weekdayNumber == 1 {
            backView.layer.cornerRadius = 24
            backView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        } else if model.weekdayNumber == 7 {
            backView.layer.cornerRadius = 24
            backView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
    }
    
    override func prepareForReuse() {
        dateLabel.text = nil
        eventCountLabel.isHidden = true
        circleView.alpha = 0
        backView.backgroundColor = .clear
        backView.cornerRadiusV = 0
    }
}
