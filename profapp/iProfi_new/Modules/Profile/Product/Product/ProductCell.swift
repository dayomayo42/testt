//
//  ProductCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 07.10.2020.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var categoryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with text: String) {
        categoryName.text = text
    }
    
    func configureCategory(with model: Category) {
        categoryName.text = model.name
    }

}
