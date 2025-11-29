import Foundation

protocol NewSubscriptionDetailsPresenterProtocol {
    var router: NewSubscriptionDetailsRouterProtocol! { get set }
    func configureView()
    func backAction()
    func changeSubscriptionAction()
    func contractOfferAction()
    func privacyPolicyAction()
    func refuseSubscriptionAction()
}

class NewSubscriptionDetailsPresenter: NewSubscriptionDetailsPresenterProtocol {
    
    var router: NewSubscriptionDetailsRouterProtocol!
    var interactor: NewSubscriptionDetailsInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func changeSubscriptionAction() {
        router.changeSubscriptionAction()
    }
    
    func contractOfferAction() {
        router.contractOfferAction()
    }
    
    func privacyPolicyAction() {
        router.privacyPolicyAction()
    }
    
    func refuseSubscriptionAction() {
        interactor.refuseTheSubscription()
    }
}
