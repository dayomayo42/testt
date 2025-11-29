//
//  SaleDistributorsCell.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation
import UIKit
import AlamofireImage

class SalesDistributorsCell: UITableViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var logoPlateView: UIView!
    
    func configure(categoryName: String, logoImageUrl: String?) {
        categoryNameLabel.text = categoryName
        if logoImageUrl == nil {
            logoPlateView.isHidden = true
            logoImageView.image = nil
        } else {
            if let url = URL(string: logoImageUrl ?? "") {
                logoPlateView.isHidden = false
                logoImageView.af_setImage(withURL: url)
            }
        }
    }
}
