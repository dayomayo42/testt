//
//  LiveJournalDetailController.swift
//  iProfi_new
//
//  Created by violy on 16.08.2022.
//

import Foundation
import UIKit

class LiveJournalDetailController: UIViewController {
    var presenter: LiveJournalDetailPresenterProtocol!
    let configurator: LiveJournalDetailConfiguratorProtocol = LiveJournalDetailConfigurator()
    
    @IBOutlet weak var openDetailsButton: UIButton!
    @IBOutlet weak var openDetailsPlate: UIView!
    @IBOutlet weak var gradientView: GradientView!
    
    var model: SliderLJ? = nil
    var shareLink: String = "https://yaprofi.app"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    @IBOutlet weak var headerTitileLabel: UILabel!
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    
    @IBAction func backAction() {
        presenter.backAction()
    }
    
    @IBAction func goToDetails() {
        guard let link = model?.url else { return }
        presenter.openWebParthner(urlString: link)
    }
    
    @IBAction func shareAction() {
        if let link = NSURL(string: shareLink) {
            let message = model?.name ?? ""
            let vc = UIActivityViewController(activityItems: [link, message], applicationActivities: nil)
            self.present(vc, animated: true)
        }
    }
}
