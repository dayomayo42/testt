//
//  ContactListCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 30.11.2020.
//

import UIKit

class ContactListCell: UITableViewCell {

    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkBoxImageView: UIImageView!
    @IBOutlet weak var checkBoxClickZoneView: UIView!
    @IBOutlet weak var contactErrorView: UIView!
    
    var onContactErrorClick: (()->())?
    var onCheckBoxSelected: ((PhoneContact, Bool)->())?
    var isCheckBoxSelected: Bool = false
    var contact: PhoneContact?
    
    func configure(contact: PhoneContact, isSelected: Bool) {
        
        let fullname = contact.firstName + " " + contact.lastName
        
        if fullname.withoutSpaces().count ?? 0 > 0 && contact.telephone.count > 0 {
            self.nameLabel.text = fullname
            self.phoneLabel.text = contact.telephone
        } else if contact.telephone.count > 0 {
            self.nameLabel.text = contact.telephone
            self.phoneLabel.text = nil
            contactErrorView.isHidden = false
            checkBoxClickZoneView.isHidden = true
        } else {
            self.nameLabel.text = fullname
            self.phoneLabel.text = contact.telephone
            contactErrorView.isHidden = false
            checkBoxClickZoneView.isHidden = true
        }
        
        self.contact = contact
        
        swithCheckBoxState(isSelected: isSelected)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkBoxClickZoneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCheckBoxAction(_:))))
        contactErrorView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onContactErrorAction(_:))))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        checkBoxClickZoneView.isHidden = false
        contactErrorView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func swithCheckBoxState(isSelected: Bool) {
        if isSelected {
            checkBoxImageView.image = UIImage(named: "checked")
            checkBoxImageView.borderWidthV = 0
            checkBoxImageView.borderColorV = .clear
            checkBoxImageView.cornerRadiusV = 0
        } else {
            checkBoxImageView.image = nil
            checkBoxImageView.borderWidthV = 1
            checkBoxImageView.borderColorV = .lightGray
            checkBoxImageView.cornerRadiusV = 4
        }
        isCheckBoxSelected = isSelected
    }
    
    @objc func onCheckBoxAction(_ sender: UITapGestureRecognizer) {
        isCheckBoxSelected.toggle()
        swithCheckBoxState(isSelected: isCheckBoxSelected)
        if let contact {
            onCheckBoxSelected?(contact, isCheckBoxSelected)
        }
    }
    
    @objc func onContactErrorAction(_ sender: UITapGestureRecognizer) {
        onContactErrorClick?()
    }
}
