//
//  NewSubscriptionCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 21.04.2022.
//
import Foundation
import UIKit

class NewSubscriptionCell: UITableViewCell {

    @IBOutlet weak var subscriptionName: UILabel!
    
    @IBOutlet weak var subscriptionDescription: UILabel!
    
    @IBOutlet weak var subscriptionPrice: UILabel!
    
    @IBOutlet weak var gradientImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(object: Subscription?) {
        self.subscriptionName.text = object?.name?.uppercased()
        self.subscriptionDescription.text = object?.convertDescriptionToString()
        self.subscriptionPrice.text = "От " + (object?.subs?.last?.price?.description ?? "") + " \(Settings.currencyCym ?? "")"
    }
}
