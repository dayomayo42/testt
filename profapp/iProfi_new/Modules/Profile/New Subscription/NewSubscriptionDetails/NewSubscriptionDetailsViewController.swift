import Foundation
import UIKit

class NewSubscriptionDetailsViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var subscriptionNameLabel: UILabel!
    @IBOutlet weak var subscriptionDescriptionLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var subscribeView: SubscribeView!
    
    @IBOutlet weak var changeSubscriptionButton: UIButton!
    @IBOutlet weak var contractOfferButton: UIButton!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    @IBOutlet weak var refuseSubscribtionButton: UIButton!
    
    var presenter: NewSubscriptionDetailsPresenterProtocol!
    let configurator: NewSubscriptionDetailsConfiguratorProtocol = NewSubscriptionDetailsConfigurator()
    var subModel: MySubscribtion? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        scrollView.isScrollEnabled = true
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func changeSubscriptionAction(_ sender: Any) {
        presenter.changeSubscriptionAction()
    }
    
    @IBAction func contractOfferAction(_ sender: Any) {
        presenter.contractOfferAction()
    }
    
    @IBAction func privacyPolicyAction(_ sender: Any) {
        presenter.privacyPolicyAction()
    }
    
    @IBAction func refuseSubscriptionAction(_ sender: Any) {
        presenter.refuseSubscriptionAction()
    }
}
