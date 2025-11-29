//
//  UpdateScreenViewController.swift
//  iProfi_new
//
//  Created by violy on 19.01.2023.
//

import Foundation
import UIKit

enum UpdateScreenState {
    case common
    case forced
    case showed
}

class UpdateScreenViewController: UIViewController {
    
    @IBOutlet weak var skipUpdateButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var presenter: UpdateScreenPresenterProtocol!
    let configurator: UpdateScreenConfiguratorProtocol = UpdateScreenConfigurator()
    
    var updateScreenState: UpdateScreenState = .common
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    @IBAction func updateAppAction() {
        presenter.openItunes()
    }

    @IBAction func skipUpdate() {
        presenter.backAction()
    }
}
