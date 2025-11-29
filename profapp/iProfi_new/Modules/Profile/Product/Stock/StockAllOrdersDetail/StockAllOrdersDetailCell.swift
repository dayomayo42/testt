//
//  StockAllOrdersDetailCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 21.01.2021.
//

import UIKit

class StockAllOrdersDetailCell: UITableViewCell {
    
    
    @IBOutlet weak var suLabel: UILabel!
    @IBOutlet weak var priceSingle: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(name: String, count: Int, price: Int, discount: Int) {
        nameLabel.text = name
        countLabel.text = "\(count) шт."
        priceSingle.text = "\(price) \(Settings.currencyCym ?? "")"
        let disc = CGFloat(100 - discount)/CGFloat(100)
        let sum = Int(disc*CGFloat(count*price))
        suLabel.text = "\(sum) \(Settings.currencyCym ?? "")"
    }

}
