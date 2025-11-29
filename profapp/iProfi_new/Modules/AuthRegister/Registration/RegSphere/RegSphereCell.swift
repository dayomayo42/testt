//
//  RegSphereCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.09.2020.
//

import UIKit

class RegSphereCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(with model: SphereModel) {
        nameLabel.text = model.name
    }
    
    func configureSpec(with model: Spec) {
        nameLabel.text = model.name?.capitalized
    }
}
