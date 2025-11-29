//
//  AnswerDetailController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import UIKit

class AnswerDetailController: UIViewController {
    var model: AnswerQuest?
    
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var questLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptLabel.text = model?.datumDescription
        questLabel.text = model?.name
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
