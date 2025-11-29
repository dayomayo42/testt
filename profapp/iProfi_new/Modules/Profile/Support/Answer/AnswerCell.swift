//
//  AnswerCell.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import UIKit

class AnswerCell: UITableViewCell {

    @IBOutlet weak var answerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with model: AnswerQuest) {
        answerLabel.text = model.name
    }
}
