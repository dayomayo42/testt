//
//  NotificationCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.12.2020.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var buttonsPlate: UIView!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var statusPlate: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var marginDescStack: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: Notification, vc: NotificationsController) {
        switch model.confirmed ?? 0 {
        case 0:
            titleLabel.text = "Онлайн запись"
            buttonsPlate.isHidden = false
            statusPlate.isHidden = true
            marginDescStack.constant = 8
            let acceptRecognizer = NotificationRecognizer(target: vc, action: #selector(vc.acceptAction(_:)))
            acceptRecognizer.headline = model.record?.id
            acceptButton.addGestureRecognizer(acceptRecognizer)
            let cancelRecognizer = NotificationRecognizer(target: vc, action: #selector(vc.cancelAction(_:)))
            cancelRecognizer.headline = model.record?.id
            cancelButton.addGestureRecognizer(cancelRecognizer)
        case 1:
            titleLabel.text = "Онлайн запись"
            buttonsPlate.isHidden = true
            statusPlate.isHidden = false
            statusLabel.text = "Подтвержден"
            statusLabel.textColor = #colorLiteral(red: 0, green: 0.4347224832, blue: 0.9958541989, alpha: 1)
            marginDescStack.constant = 8
        case 2:
            titleLabel.text = "Онлайн запись"
            buttonsPlate.isHidden = true
            statusPlate.isHidden = false
            statusLabel.text = "Отменен"
            statusLabel.textColor = #colorLiteral(red: 0.9677701592, green: 0.230127275, blue: 0.2682518363, alpha: 1)
            marginDescStack.constant = 8
        case 3:
            titleLabel.text = model.title
            buttonsPlate.isHidden = true
            statusPlate.isHidden = true
            marginDescStack.constant = 0
        default: break
        }
        
        descriptionLabel.text = model.text
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
