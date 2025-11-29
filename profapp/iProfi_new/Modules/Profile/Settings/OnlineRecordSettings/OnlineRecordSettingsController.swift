//
//  OnlineRecordSettingsController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.12.2020.
//

import UIKit

class OnlineRecordSettingsController: UIViewController {
    var userModel: UserModel?
    
    @IBOutlet weak var onlineSwitch: UISwitch!
    @IBOutlet weak var siteLabel: UILabel!
    var presenter: OnlineRecordSettingsPresenterProtocol!
    let configurator: OnlineRecordSettingsConfiguratorProtocol = OnlineRecordSettingsConfigurator()
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }

    @IBAction func backActio(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func onlineAction(_ sender: UISwitch) {
        presenter.sendEditedOnline() // TODO: check this shit
    }
    
    @IBAction func shareSite(_ sender: Any) {
        UIPasteboard.general.string = userModel?.siteLink
    }
    
    @IBAction func openSite(_ sender: Any) {
        presenter.openSite(with: userModel?.siteLink ?? "https://yaprofi.app")
    }
}
