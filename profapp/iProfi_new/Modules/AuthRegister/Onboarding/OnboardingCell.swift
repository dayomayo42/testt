//
//  OnboardingCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.04.2021.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightCostrait: NSLayoutConstraint!
    @IBOutlet weak var cotainerWidth: NSLayoutConstraint!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    
    func configure(model: OnBoardModel) {
        titleLabel.text = model.title
        descLabel.text = model.desc
        imageView.image = model.image
    }
    
    
    override func awakeFromNib() {
        widthConstraint.constant = UIScreen.main.bounds.width
        heightCostrait.constant = (UIScreen.main.bounds.width/375) * 296
        
        cotainerWidth.constant = UIScreen.main.bounds.width
        containerHeight.constant = UIScreen.main.bounds.height - 160
    }
}
