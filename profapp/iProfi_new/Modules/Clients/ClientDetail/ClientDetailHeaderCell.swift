//
//  ClientDetailHeaderCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.10.2020.
//

import UIKit

class ClientDetailHeaderCell: UITableViewCell {
    
    @IBOutlet weak var statusPlate: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var userAvatarView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userStatusView: UIView!
    @IBOutlet weak var userStatusLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var phoineNumber: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var createRecordButton: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(with model: Client) {
        if model.lastname?.count ?? 0 > 0 {
            userNameLabel.text = "\(model.lastname ?? "")\n\(model.name ?? "") \(model.midname ?? "")"
        } else {
            userNameLabel.text = "\(model.name ?? "")"
        }
        
        if model.image != "" {
            userAvatarView.af_setImage(withURL: URL(string: (model.image!))!)
        } else {
            userAvatarView.image = #imageLiteral(resourceName: "Big")
        }
        
        if model.waited ?? false {
            userStatusLabel.text = "Лист ожидания"
            userStatusView.backgroundColor = #colorLiteral(red: 1, green: 0.6360965371, blue: 0, alpha: 1)
        } else if model.blocked ?? false {
            userStatusLabel.text = "Заблокированный"
            userStatusView.backgroundColor = #colorLiteral(red: 0.8941176471, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
        } else {
            switch model.status {
            case 0:
                userStatusLabel.text = "Новый"
                userStatusView.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            case 1:
                userStatusLabel.text = "Постоянный"
                userStatusView.backgroundColor = #colorLiteral(red: 0, green: 0.8690080047, blue: 0.3919513524, alpha: 1)
            case 2:
                userStatusLabel.text = "Спящий"
                userStatusView.backgroundColor = #colorLiteral(red: 0.6391654015, green: 0.6392440796, blue: 0.6391386986, alpha: 1)
            case 3:
                userStatusLabel.text = "Потерянный"
                userStatusView.backgroundColor = #colorLiteral(red: 0.6391654015, green: 0.6392440796, blue: 0.6391386986, alpha: 1)
            default:
                break
            }
        }
        
        phoineNumber.text = model.phone
        mailLabel.text = model.email
        noteLabel.text = model.note
        
        //statusLabel
        
        if model.blocked ?? false {
            statusLabel.text = "Заблокирован"
        } else if model.waited ?? false {
            statusLabel.text = "Лист ожидания"
        } else {
            statusLabel.text = "Активный"
        }
    }
}
