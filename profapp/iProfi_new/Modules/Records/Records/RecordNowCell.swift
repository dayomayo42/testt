//
//  RecordNowCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import UIKit

class RecordNowCell: UITableViewCell {
    
    @IBOutlet var serviceName: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var clientAvatar: UIImageView!
    @IBOutlet var clientName: UILabel!
    
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
        timeLabel.text = "Началось в \(model.date?.convertDate(to: 0) ?? "")" 
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
