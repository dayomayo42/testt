//
//  InstructionsDetailController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.06.2021.
//

import UIKit

class InstructionsDetailController: UIViewController {
    var selectedId: Int = 0
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var guideImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
      //  guideImage.image = UIImage(named: "\(selectedId + 1)")
        guideImage.image = #imageLiteral(resourceName: "\(selectedId + 1)")
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
