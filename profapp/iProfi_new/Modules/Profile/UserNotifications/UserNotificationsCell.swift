//
//  UserNotificationsCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 31.08.2021.
//

import UIKit

class UserNotificationsCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var contentPlate: UIView!
    
    func configure(model: ClientNotif) {
        dateLabel.text = model.time
        
        if let clients = model.item?.client {
            
            if clients.count == 1, let url = URL(string: clients.first?.image ?? "") {
                userAvatar.af.setImage(withURL: url)
            } else {
                userAvatar.image = #imageLiteral(resourceName: "user")
            }
            
            if clients.count == 1, let client = clients.first {
                infoLabel.text = "Отправьте клиенту \(client.name ?? "") напоминание о визите \(model.item?.date ?? "")"
            } else if clients.count > 1 {
                infoLabel.text = "Отправьте клиентам напоминание о визите \(model.item?.date ?? "")"
            }
        }
    
        if model.item?.read ?? false {
            contentPlate.borderColorV = #colorLiteral(red: 0.8975607753, green: 0.9218515158, blue: 0.9431785345, alpha: 1)
        } else {
            contentPlate.borderColorV = #colorLiteral(red: 0, green: 0.4518190622, blue: 0.995408833, alpha: 1)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
