//
//  InfoblockCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import UIKit

class InfoblockCell: UICollectionViewCell {
    
    @IBOutlet var mainPlate: UIView!
    @IBOutlet var titleLabel: UILabel!
    
    var isActive: Bool = false {
        didSet {
            if isActive {
                mainPlate.borderColorV = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                mainPlate.backgroundColor = UIColor(named: "appBlue")
                titleLabel.textColor = .white
            } else {
                mainPlate.borderColorV = #colorLiteral(red: 0.8978094459, green: 0.9220479131, blue: 0.943356812, alpha: 1)
                mainPlate.backgroundColor = .white
                titleLabel.textColor = UIColor(named: "appBlue")
            }
        }
    }
    
    func configure(with text: String) {
        titleLabel.text = text
        mainPlate.borderWidthV = 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        isActive = false
    }
}
