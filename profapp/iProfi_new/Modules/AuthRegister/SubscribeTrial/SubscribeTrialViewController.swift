//
//  SubscribeTrialViewController.swift
//  iProfi_new
//
//  Created by violy on 20.01.2023.
//

import Foundation
import UIKit

enum SubTrialState {
    case common
    case expired
}

class SubscribeTrialViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var blueMainButton: UIButton!
    @IBOutlet weak var whiteSecondaryButton: UIButton!
    
    var subState: SubTrialState = .common
    
    var presenter: SubscribeTrialPresenterProtocol!
    let configurator: SubscribeTrialConfiguratorProtocol = SubscribeTrialConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    @IBAction func onMainBlueButtonAction() {
        switch subState {
        case .common:
            presenter.openStartScreen()
        case .expired:
            presenter.openSubscriptions()
        default:
            break
        }
    }
    
    @IBAction func onSecondaryWhiteButtonAction() {
        presenter.backAction()
    }
    
}
