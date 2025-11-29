//
//  ArrivalProductView.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.12.2020.
//

import Foundation
import UIKit

class ArrivalProductView: UIView {
    
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var thrashLabel: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func configureView(name: String, provider: String, price: String) {
        nameLabel.text = name
        providerLabel.text = provider
        priceLabel.text = price
    }

    private func commonInit() {
        fromNib()
    }
}
