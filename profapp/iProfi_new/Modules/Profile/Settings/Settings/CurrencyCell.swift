//
//  CurrencyCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.11.2020.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    @IBOutlet weak var selectDot: UIView!
    @IBOutlet weak var curLogo: UIImageView!
    @IBOutlet weak var curName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(title: String, icon: UIImage) {
        curName.text = title
        curLogo.image = icon
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
