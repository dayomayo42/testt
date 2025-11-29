//
//  RecordServiceCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 26.10.2020.
//

import UIKit

class RecordsServiceCell: UITableViewCell {

    @IBOutlet weak var checkedView: UIImageView!
    @IBOutlet weak var servicePrice: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(with service: Service) {
        if service.isSelected {
            checkedView.isHidden = false
        } else {
            checkedView.isHidden = true
        }
        nameLabel.text = service.name
        servicePrice.text = "\(service.price?.getFormatedPrice() ?? "") / \(service.duration ?? 0) мин."
    }
}
