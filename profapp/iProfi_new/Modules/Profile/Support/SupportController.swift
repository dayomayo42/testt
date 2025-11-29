//
//  SupportController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import UIKit

class SupportController: UIViewController {

    var presenter: SupportPresenterProtocol!
    let configurator: SupportConfiguratorProtocol = SupportConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }

    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func feedbackAction(_ sender: Any) {
        presenter.openFeedback()
    }
    
    @IBAction func answerAction(_ sender: Any) {
        presenter.openAnswer()
    }
}
