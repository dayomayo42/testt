//
//  RecordsCalendarMonthWeekdayCell.swift
//  iProfi_new
//
//  Created by violy on 27.04.2023.
//

import Foundation
import UIKit

class RecordsCalendarMonthWeekdayCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(weekDay: String) {
        titleLabel.text = weekDay
    }
}
    
