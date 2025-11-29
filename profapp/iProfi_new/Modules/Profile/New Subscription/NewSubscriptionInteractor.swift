import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol NewSubscriptionInteractorProtocol {
    func configureView()
    func getDataFromBackend(completion: @escaping ([Subscription]?) -> ())
}

class NewSubscriptionInteractor: NewSubscriptionInteractorProtocol {
    var viewController: NewSubscriptionController!
    var presenter: NewSubscriptionPresenterProtocol!
    private let networkingLayer = NetworkingViewModel()
    private let disposeBag = DisposeBag()
    
    init(viewController: NewSubscriptionController, presenter: NewSubscriptionPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        getDataFromBackend { data in
            self.viewController.subsArr = data ?? []
        }
    }
    
    
    func getDataFromBackend(completion: @escaping ([Subscription]?) -> ()) {
        viewController.showHUD(show: true)
        networkingLayer.getSubs().subscribe { (response) in
            SVProgressHUD.dismiss()
            guard self.viewController != nil else { return }
            guard let data = response.data else { return }
            completion(data)
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
            completion(nil)
        }.disposed(by: disposeBag)
    }
}


