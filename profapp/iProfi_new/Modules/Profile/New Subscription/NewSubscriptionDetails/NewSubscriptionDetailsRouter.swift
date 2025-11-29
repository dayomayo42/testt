import Foundation

protocol NewSubscriptionDetailsRouterProtocol {
    func backAction()
    func changeSubscriptionAction()
    func contractOfferAction()
    func privacyPolicyAction()
}

class NewSubscriptionDetailsRouter: NewSubscriptionDetailsRouterProtocol {
    
    var viewController: NewSubscriptionDetailsViewController!
    var serverService: ServerServiceProtocol = ServerService()
    
    init(viewController: NewSubscriptionDetailsViewController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func changeSubscriptionAction() {
        let vc = viewController.getControllerProfile(controller: .subscription) as! NewSubscriptionController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func contractOfferAction() {
        serverService.openUrl(with: "https://profapp.app/doc/offer.pdf")
    }
    
    func privacyPolicyAction() {
        serverService.openUrl(with: "https://profapp.app/doc/policy.pdf")
    }
}
