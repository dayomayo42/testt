//
//  RememberSuccessController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.09.2020.
//

import UIKit

class RememberSuccessController: UIViewController {
    var presenter: RememberSuccessPresenter!
    let configurator: RememberSuccessConfiguratorProtocol = RememberSuccessConfigurator()
    var phoneNumber: String = ""
    @IBOutlet weak var descriptionText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView(with: phoneNumber)
    }
    
    @IBAction func nextAction(_ sender: Any) {
        presenter.dismissAction()
    }
}
