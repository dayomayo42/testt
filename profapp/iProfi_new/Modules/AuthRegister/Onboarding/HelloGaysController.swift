//
//  HelloGaysController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.04.2021.
//

import UIKit

class HelloGaysController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func nextAction(_ sender: Any) {
        let vc = getController(controller: .onboarding)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
