//
//  RecordsProductsHeaderCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 26.10.2020.
//

import UIKit

class RecordsProductsHeaderCell: UITableViewCell {

    @IBOutlet weak var categoryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with name: String) {
        categoryName.text = name
    }
}
