//
//  WeekDateCell.swift
//  iProfi_new
//
//  Created by violy on 26.05.2023.
//

import Foundation
import UIKit

class WeekDateCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    func configure(day: String?, month: String?) {
        guard let day, let month else {
            dayLabel.isHidden = true
            monthLabel.isHidden = true
            return
        }
        
        dayLabel.text = day
        monthLabel.text = month
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dayLabel.isHidden = false
        monthLabel.isHidden = false
    }
}
