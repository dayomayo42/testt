//
//  StockOrderCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.11.2020.
//

import UIKit

class StockOrderCell: UITableViewCell {
    
    @IBOutlet weak var debtorLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameHeader: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(name: String, number: Int, debt: Int, date: String) {
        if debt > 0{
            nameHeader.backgroundColor = #colorLiteral(red: 0.9677701592, green: 0.230127275, blue: 0.2682518363, alpha: 1)
        } else {
            nameHeader.backgroundColor = #colorLiteral(red: 0, green: 0.8690080047, blue: 0.3919513524, alpha: 1)
        }
        
        
        nameLabel.text = name
        dateLabel.text = date
        
        orderLabel.text = "Заказ № \(number)"
        
        if debt < 0 {
            debtorLabel.text = "Переплата - \(debt*(-1)) \(Settings.currencyCym ?? "")"
        } else {
            debtorLabel.text = "Сумма долга - \(debt) \(Settings.currencyCym ?? "")"
        }
    }
    
    func configureNumber(number: [Int]) {
        if number.count > 0 {
            if number.count > 1 {
                var title = ""
                number.forEach { (num) in
                    title += "\(num), "
                }
                print(title)
                orderLabel.text = "Заказы № \(title.dropLast(2))"
            } else {
                orderLabel.text = "Заказ № \(number.first ?? 0)"
            }
        }
    }

}
