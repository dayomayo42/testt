//
//  RecordsCalendarMonthCell.swift
//  iProfi_new
//
//  Created by violy on 26.04.2023.
//

import Foundation
import UIKit

class RecordsCalendarMonthNameCell: UICollectionViewCell {
    @IBOutlet weak var monthLabel: UILabel!
    
    func configure(_ name: String) {
        monthLabel.text = name
        layoutSubviews()
    }
}
