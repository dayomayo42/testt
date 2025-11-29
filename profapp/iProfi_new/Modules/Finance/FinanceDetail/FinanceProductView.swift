//
//  FinanceProductView.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.11.2020.
//

import UIKit

class FinanceProductView: UIView {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var object: Finance?
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func showHideCross() {
        UIView.animate(withDuration: 0.3) {
            self.buttonView.isHidden = !self.buttonView.isHidden
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        fromNib()
    }
    
    func configure(name: String, price: String) {
        priceLabel.text = price
        nameLabel.text = name
    }
}
