//
//  CalendarDayCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 16.11.2020.
//

import UIKit

class CalendarDayCell: UITableViewCell {

    @IBOutlet weak var plateView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeslabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(record: Records) {
        let current = Date().getCurrentGmtDate()
        
        if let clients = record.client {
            if clients.count == 1, let client = clients.first {
                nameLabel.text = "\(client.name ?? "") \(client.lastname ?? "")"
            } else if clients.count > 1, let client = clients.first {
                nameLabel.text = "\(client.name ?? "") \(client.lastname ?? "") + eще \(clients.count - 1)"
            }
        }
        
        let endTime = record.date?.convertDateToDate().add(component: .minute, value: record.duration ?? 0).getTime()
        timeslabel.text = "\(record.date?.convertDate(to: 0) ?? "") - \(endTime ?? "")"
        
        if record.date?.convertDateToDate().timeIntervalSince1970 ?? 0 > current.timeIntervalSince1970 {
            //будет
            plateView.backgroundColor = #colorLiteral(red: 0, green: 0.4347205758, blue: 0.9958539605, alpha: 1)
            if record.status == 1 {
                plateView.backgroundColor = #colorLiteral(red: 0.9677701592, green: 0.230127275, blue: 0.2682518363, alpha: 1)
            }
        } else if Int(current.timeIntervalSince1970 - (record.date?.convertDateToDate().timeIntervalSince1970 ?? 0)) < (record.duration ?? 0)*60 {
            //в процессе
            if record.status == 0 {
                plateView.backgroundColor = #colorLiteral(red: 1, green: 0.796792984, blue: 0, alpha: 1)
            } else if record.status == 1 {
                plateView.backgroundColor = #colorLiteral(red: 0.9677701592, green: 0.230127275, blue: 0.2682518363, alpha: 1)
            }
        } else {
            //завершено
            plateView.backgroundColor = #colorLiteral(red: 0, green: 0.8690080047, blue: 0.3919513524, alpha: 1)
            if record.status == 1 {
                plateView.backgroundColor = #colorLiteral(red: 0.9677701592, green: 0.230127275, blue: 0.2682518363, alpha: 1)
            }
        }
    }

}
