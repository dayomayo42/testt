//
//  RecordTimeCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 05.11.2020.
//

import UIKit

class RecordTimeCell: UICollectionViewCell {
    @IBOutlet weak var cellPlate: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    func configure(with time: String) {
        timeLabel.text = time
    }
}
