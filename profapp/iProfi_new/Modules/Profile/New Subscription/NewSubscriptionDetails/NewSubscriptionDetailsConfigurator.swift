import Foundation

protocol NewSubscriptionDetailsConfiguratorProtocol {
    func configure(with viewController: NewSubscriptionDetailsViewController)
}

class NewSubscriptionDetailsConfigurator: NewSubscriptionDetailsConfiguratorProtocol {
    func configure(with viewController: NewSubscriptionDetailsViewController) {
        let presenter = NewSubscriptionDetailsPresenter()
        let interactor = NewSubscriptionDetailsInteractor(viewController: viewController, presenter: presenter)
        let router = NewSubscriptionDetailsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
