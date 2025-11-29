//
//  StockDebtsCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.11.2020.
//

import UIKit

class StockDebtsCell: UITableViewCell {
    
    @IBOutlet weak var productsList: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func configure(product: String, debt: Int, title: String) {
        productsList.text = product
        priceLabel.text = "Сумма долга - \(debt) \(Settings.currencyCym ?? "")"
        titleLabel.text = title
    }

}
