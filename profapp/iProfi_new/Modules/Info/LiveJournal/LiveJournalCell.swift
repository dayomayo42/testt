//
//  LiveJournalCell.swift
//  iProfi_new
//
//  Created by violy on 16.08.2022.
//

import Foundation
import UIKit

class LiveJournalCell: UITableViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    func configure(name: String) {
        categoryNameLabel.text = name
    }
}

