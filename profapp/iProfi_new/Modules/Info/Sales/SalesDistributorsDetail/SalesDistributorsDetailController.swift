//
//  SalesDistributorsDetailController.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation
import UIKit
import SVProgressHUD

class SalesDistributorsDetailController: UIViewController {
    var presenter: SalesDistributorsDetailPresenterProtocol!
    
    
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var saleLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageTitleLabel: UILabel!
    
    @IBOutlet weak var promocodePlate: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var promocodeButton: UIButton!
    
    @IBOutlet weak var salesDescriptionPlate: UIView!
    
    @IBOutlet weak var saleDescriptionTextView: UITextView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var shareLink: String = ""
    
    let configurator: SalesDistributorsDetailConfiguratorProtocol = SalesDistributorsDetailConfigurator()
    
    var model: SliderSales?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    @IBAction func backAction() {
        presenter.backAction()
    }
    
    @IBAction func likeAction() {
        presenter.setLikeDislike()
    }
    
    @IBAction func shareAction() {
        if let link = NSURL(string: shareLink) {
            let message = model?.name ?? ""
            let vc = UIActivityViewController(activityItems: [link, message], applicationActivities: nil)
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func buyAction() {
        if let url = model?.url {
            presenter.openWebParthner(urlString: url)
        }
    }
    
    @IBAction func onPromoCopyAction() {
        if !((promocodeButton.title(for: .normal))?.isEmpty ?? true) {
            UIPasteboard.general.string = promocodeButton.title(for: .normal)
            SVProgressHUD.showDismissableSuccess(withStatus: "Промокод успешно скопирован!")
        }
    }
}
