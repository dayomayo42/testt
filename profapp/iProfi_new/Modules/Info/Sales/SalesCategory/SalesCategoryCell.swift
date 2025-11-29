//
//  SalesCategoryCell.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation
import UIKit

class SalesCategoryCell: UITableViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    func configure(name: String) {
        categoryNameLabel.text = name
    }
}
