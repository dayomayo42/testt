//
//  RecordHeaderCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import UIKit

enum RecordHeaderConfig {
    case now
    case next
    case cancelled
}

class RecordHeaderCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func configure(type: RecordHeaderConfig) {
        switch type {
        case .now:
            titleLabel.text = "Текущая запись"
        case .next:
            titleLabel.text = "Запланированные записи"
        case .cancelled:
            titleLabel.text = "Отменённые записи"
        }
    }
}
