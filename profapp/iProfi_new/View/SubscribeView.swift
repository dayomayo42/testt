//
//  SubscribeView.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 17.05.2022.
//

import UIKit

class SubscribeView: UIView {

    @IBOutlet weak var basePlate: UIView!
    @IBOutlet weak var profitLabel: UIView!
    @IBOutlet weak var economyLabel: UILabel!
    @IBOutlet weak var fullPriceLabel: UILabel!
    @IBOutlet weak var pricePerMonthLabel: UILabel!
    @IBOutlet weak var backgroundGradient: UIImageView!
    @IBOutlet weak var intervalLabel: UILabel!
    
    
    @IBInspectable var whiteStyle: Bool {
        get {
            return backgroundGradient.isHidden
        }
        
        set {
            if newValue {
                configureWhiteStyle()
            }
        }
    }
    
    func configureWhiteStyle() {
        profitLabel.isHidden = true
        backgroundGradient.isHidden = true
        
        intervalLabel.textColor = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1607843137, alpha: 1)
        pricePerMonthLabel.textColor = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1607843137, alpha: 1)
        fullPriceLabel.textColor = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1607843137, alpha: 1)
        economyLabel.textColor = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1607843137, alpha: 1)
        basePlate.borderWidthV = 1
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        fromNib()
    }
    
}
