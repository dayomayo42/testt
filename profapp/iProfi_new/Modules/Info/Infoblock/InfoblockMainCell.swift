//
//  InfoblockMainCell.swift
//  iProfi_new
//
//  Created by violy on 28.09.2022.
//

import Foundation
import UIKit

class InfoblockMainCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
