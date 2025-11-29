//
//  CategoryDetailCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 12.10.2020.
//

import UIKit

class CategoryDetailCell: UITableViewCell {

    @IBOutlet weak var pricaLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(with model: String) {
        titleLabel.text = "Продукт \(model)"
    }
    
    func configureProduct(with model: Product) {
        titleLabel.text = model.name
        pricaLabel.text = model.price?.getFormatedPrice()
    }
    
    func configureService(with model: Service) {
        titleLabel.text = model.name
        pricaLabel.text = "\(model.price?.getFormatedPrice() ?? "") / \(model.duration ?? 0) мин."
    }
}
