//
//  ClientDetailRecordsCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.10.2020.
//

import UIKit

class ClientDetailRecordsCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var statusViewPoint: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(model: Records) {
        timeLabel.text = model.date

        let current = Date().getCurrentGmtDate()
        if model.date?.convertDateToDate().timeIntervalSince1970 ?? 0 > current.timeIntervalSince1970 {
            //будет
            statusText.textColor = #colorLiteral(red: 1, green: 0.796792984, blue: 0, alpha: 1)
            statusText.text = "Запланировано"
            if model.status == 1 {
                statusText.textColor = #colorLiteral(red: 0.9677701592, green: 0.230127275, blue: 0.2682518363, alpha: 1)
                statusText.text = "Отменено"
            }
        } else if Int(current.timeIntervalSince1970 - (model.date?.convertDateToDate().timeIntervalSince1970 ?? 0)) < (model.duration ?? 0)*60 {
            //в процессе
            if model.status == 0 {
                statusText.textColor = #colorLiteral(red: 0, green: 0.4347224832, blue: 0.9958541989, alpha: 1)
                statusText.text = "Текущее"
            } else if model.status == 1 {
                statusText.textColor = #colorLiteral(red: 0.9677701592, green: 0.230127275, blue: 0.2682518363, alpha: 1)
                statusText.text = "Отменено"
            }
        } else {
            //завершено
            statusText.textColor = #colorLiteral(red: 0, green: 0.8690080047, blue: 0.3919513524, alpha: 1)
            statusText.text = "Завершено"
            if model.status == 1 {
                statusText.textColor = #colorLiteral(red: 0.9677701592, green: 0.230127275, blue: 0.2682518363, alpha: 1)
                statusText.text = "Отменено"
            }
        }
        statusViewPoint.backgroundColor = statusText.textColor
    }
}
