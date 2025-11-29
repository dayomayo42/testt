//
//  FinanceCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.11.2020.
//

import UIKit

class FinanceCell: UITableViewCell {

    @IBOutlet weak var titleView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(with title: String) {
        titleView.text = title
    }

}
