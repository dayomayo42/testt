//
//  MyStudyCell.swift
//  iProfi_new
//
//  Created by violy on 12.08.2022.
//

import Foundation
import UIKit

class MyStudyCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    var studyID: Int?
    
    func configure(title: String, id: Int) {
        studyID = id
        titleLabel.text = title
    }
}
