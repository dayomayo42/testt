//
//  ProductStockCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 08.10.2020.
//

import UIKit

class ProductStockCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(with text: String) {
        titleLabel.text = text
    }
    
    func configure(with model: Supplier) {
        titleLabel.text = model.name
    }
    
    func configure(with model: StockProduct) {
        titleLabel.text = model.name
    }

}
