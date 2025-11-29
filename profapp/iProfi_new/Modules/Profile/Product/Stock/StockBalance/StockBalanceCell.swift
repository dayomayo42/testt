//
//  StockBalanceCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 16.12.2020.
//

import UIKit

class StockBalanceCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(name: String, price: Int, count: Int) {
        nameLabel.text = name
        priceLabel.text = "\(price) \(Settings.currencyCym ?? "")"
        countLabel.text = "\(count) шт."
    }
    

}
