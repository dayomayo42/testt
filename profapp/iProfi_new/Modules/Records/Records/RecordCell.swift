//
//  RecordCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import UIKit

class RecordCell: UITableViewCell {
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var serviceName: UILabel!
    @IBOutlet var clientName: UILabel!
    @IBOutlet var clientAvatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(with model: Records) {
        
        if let clients = model.client {
            if clients.count == 1, let client = clients.first {
                clientName.text = "\(client.lastname ?? "") \(client.name ?? "")"
                if !(client.image?.isEmpty ?? true), let url = URL(string: (client.image) ?? "") {
                    clientAvatar.af.setImage(withURL: url)
                } else {
                    clientAvatar.image = #imageLiteral(resourceName: "Big")
                }
            } else if clients.count > 1, let firstClient = clients.first {
                clientName.text = "\(firstClient.lastname ?? "") \(firstClient.name ?? "") + еще \(clients.count - 1) \(CountWords.word(for: clients.count-1, from: ["клиент", "клиента", "клиентов"]))"
                clientAvatar.image = #imageLiteral(resourceName: "user_now")
            } else if clients.isEmpty {
                clientName.text = "Неизвестный клиент"
                clientAvatar.image = #imageLiteral(resourceName: "Big")
            }
        }

        var serviceNames = ""
        for item in model.services ?? [] {
            serviceNames += ", \(item.name ?? "")"
        }
        serviceNames = String(serviceNames.dropFirst(2))
        serviceName.text = serviceNames
        if model.status == 0 {
            timeLabel.textColor = #colorLiteral(red: 1, green: 0.6360965371, blue: 0, alpha: 1)
            timeLabel.text = model.date
        } else if model.status == 1 {
            timeLabel.textColor = #colorLiteral(red: 0.9677701592, green: 0.230127275, blue: 0.2682518363, alpha: 1)
            timeLabel.text = "Отменено"
        } else if model.status == 2 {
            timeLabel.textColor = #colorLiteral(red: 0.3647058824, green: 0.8509803922, blue: 0.4470588235, alpha: 1)
            timeLabel.text = model.date
        } else if model.status == 3 {
            timeLabel.textColor = #colorLiteral(red: 1, green: 0.6360965371, blue: 0, alpha: 1)
            timeLabel.text = model.date
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timeLabel.text = ""
        clientName.text = ""
        serviceName.text = ""
        clientAvatar.af.cancelImageRequest()
        clientAvatar.image = nil
    }
}
