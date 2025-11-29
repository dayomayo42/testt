//
//  SettingsController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 03.11.2020.
//

import UIKit

protocol CurrencyDelegate: class {
    var model: CurrencyModel? {get set}
}

class SettingsController: UIViewController, CurrencyDelegate {
    var model: CurrencyModel? {
        didSet {
            presenter.configure(with: model!)
        }
    }
    
    var presenter: SettingsPresenterProtocol!
    let configurator: SettingsConfiguratorProtocol = SettingsConfigurator()
    
    @IBOutlet weak var currencyView: UIButton!
    @IBOutlet weak var switchView: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    @IBAction func currencyAction(_ sender: Any) {
        presenter.chooseCurrency()
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        if sender.isOn {
            presenter.accessCalendar()
        } else {
            Settings.calendar = sender.isOn
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
}
