//
//  StockAllOrdersDetailHeader.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 21.01.2021.
//

import UIKit

class StockAllOrdersDetailHeader: UITableViewCell {

    @IBOutlet weak var orderSum: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var clientName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(name: String, date: String, sum: String) {
        clientName.text = name
        orderDate.text = date
        orderSum.text = sum
    }
}
