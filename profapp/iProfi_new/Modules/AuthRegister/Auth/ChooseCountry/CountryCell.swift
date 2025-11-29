//
//  CountryCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 31.08.2020.
//

import UIKit
import AlamofireImage

class CountryCell: UITableViewCell {

    @IBOutlet weak var cellPlate: UIView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var flagView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(from model: CountriesModel) {
        countryName.text = "+\(model.phoneMask ?? "") \(model.code?.countryName() ?? "")"
        flagView.image = UIImage(named: model.resName ?? "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
