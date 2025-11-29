//
//  ClientsControllerCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import UIKit

enum ClientType {
    case regular 
    case waiting
    case sleeping
    case fallen
    case blocked
}

class ClientsCell: UITableViewCell {

    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var clientAvatar: UIImageView!
    @IBOutlet weak var clientType: UILabel!
    
    var isMultipleSelectActive = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        guard isMultipleSelectActive else { return }
        if selected {
            contactView.borderColorV = UIColor(named: "appBlue") ?? .blue
            contactView.borderWidthV = 3.0
        } else {
            contactView.borderColorV = UIColor(named: "borderColor") ?? .gray
            contactView.borderWidthV = 1.0
        }
    }
    
    func configure(with model: Client) {
        if model.waited ?? false {
            clientType.text = "Лист ожидания"
            clientType.textColor = #colorLiteral(red: 1, green: 0.6360965371, blue: 0, alpha: 1)
        } else if model.blocked ?? false {
            clientType.text = "Заблокированный"
            clientType.textColor = #colorLiteral(red: 0.8941176471, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
        } else {
            switch model.status {
            case 0:
                clientType.text = "Новый"
                clientType.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            case 1:
                clientType.text = "Постоянный"
                clientType.textColor = #colorLiteral(red: 0, green: 0.8690080047, blue: 0.3919513524, alpha: 1)
            case 2:
                clientType.text = "Спящий"
                clientType.textColor = #colorLiteral(red: 0.6391654015, green: 0.6392440796, blue: 0.6391386986, alpha: 1)
            case 3:
                clientType.text = "Потерянный"
                clientType.textColor = #colorLiteral(red: 0.6391654015, green: 0.6392440796, blue: 0.6391386986, alpha: 1)
            default:
                break
            }
        }
        
        if model.image != "" {
            clientAvatar.af_setImage(withURL: URL(string: model.image!)!)
        } else {
            clientAvatar.image = #imageLiteral(resourceName: "Big")
        }
        
        clientName.text = "\(model.lastname ?? "") \(model.name ?? "")"
    }
}
