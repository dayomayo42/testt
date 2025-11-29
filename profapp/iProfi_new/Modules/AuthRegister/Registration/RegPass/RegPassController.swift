//
//  RegPassController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 03.09.2020.
//

import UIKit

class RegPassController: UIViewController {
    
    @IBOutlet weak var timerText: UILabel!
    @IBOutlet weak var timerPlate: UIView!
    @IBOutlet weak var repeatePassButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var confirmationNumberPhoneLabel: UILabel!
    
    var presenter: RegPassPresenter!
    let configurator: RegPassConfiguratorProtocol = RegPassConfigurator()
    
    var model: RegisterModel?
    var callModel: SendCallModel?
    var isTestNumber = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter.onViewDissapear()
    }

    @IBAction func nextAction(_ sender: Any) {
        presenter.makeCall()
    }

    @IBAction func repeatePassAction(_ sender: Any) {
        presenter.repeatePass()
    }
}
