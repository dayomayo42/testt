//
//  CalendarFreeCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 04.12.2020.
//

import UIKit

class CalendarFreeCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(record: Records) {
        titleLabel.text = "\(record.date?.convertDate(to: 0) ?? "")  Свободно"
    }

}
