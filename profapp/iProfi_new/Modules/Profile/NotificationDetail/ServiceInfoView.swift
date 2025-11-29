//
//  ServiceIfoView.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 03.12.2020.
//

import Foundation
import UIKit

class ServiceInfoView: UIView {
    @IBOutlet weak var separatorLabel: UIView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
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
