//
//  SheduleView.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.10.2020.
//

import UIKit

class ShaduleView: UIView {

    @IBOutlet weak var dayName: UILabel!
    @IBOutlet weak var beginPlate: UIView!
    @IBOutlet weak var beginTime: UILabel!
    @IBOutlet weak var endPlate: UIView!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var breakPlate: UIView!
    @IBOutlet weak var breakTime: UILabel!
    @IBOutlet weak var accessPlate: UIView!
    
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
