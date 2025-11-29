//
//  ProductHeaderCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 07.10.2020.
//

import UIKit

class ProductHeaderCell: UITableViewCell {

    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var mainPlate: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
