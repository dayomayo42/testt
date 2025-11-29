//
//  StudyCategoryCell.swift
//  iProfi_new
//
//  Created by violy on 11.08.2022.
//

import Foundation
import UIKit
import AlamofireImage

class StudyCategoryCell: UITableViewCell {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var logoViewPlate: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    func configure(categoryName: String, logoImageUrl: String?) {
        categoryNameLabel.text = categoryName
        if logoImageUrl == nil {
            logoViewPlate.isHidden = true
            logoImageView.image = nil
        } else {
            if let url = URL(string: logoImageUrl ?? "") {
                logoViewPlate.isHidden = false
                logoImageView.contentMode = .scaleAspectFit
                logoImageView.af_setImage(withURL: url)
            }
        }
    }
}
