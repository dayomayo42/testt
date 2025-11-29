import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol NewSubscriptionDetailsInteractorProtocol {
    func configureView()
    func refuseTheSubscription()
}

class NewSubscriptionDetailsInteractor: NewSubscriptionDetailsInteractorProtocol {
    var viewController: NewSubscriptionDetailsViewController!
    var presenter: NewSubscriptionDetailsPresenterProtocol!
    private let networkingLayer = NetworkingViewModel()
    private let disposeBag = DisposeBag()
    
    init(viewController: NewSubscriptionDetailsViewController,
         presenter: NewSubscriptionDetailsPresenterProtocol) {
        self.presenter = presenter
        self.viewController = viewController
    }
    
    func configureView() {
        guard let vc = viewController else { return }
        
        Settings.subTrial = viewController.subModel?.trial == 1
        
        let currSubId = viewController.subModel?.id ?? 1
        var subMounth: String? = nil
        
        if viewController.subModel?.type?.duration != 1 {
            subMounth = " месяцев"
        } else {
            subMounth = " месяц"
        }
        
        vc.subscriptionNameLabel.text = vc.subModel?.type?.name?.uppercased() ?? ""
        vc.subscriptionDescriptionLabel.text = vc.subModel?.type?.convertDescriptionToString() ?? ""
        
        if vc.subModel?.type?.duration ?? 0 > 1 && vc.subModel?.trial != 1 {
            vc.subscribeView.economyLabel.text = (vc.subModel?.type?.price?.description ?? "") + "\(Settings.currencyCym ?? "") / мес."
        } else {
            vc.subscribeView.economyLabel.removeFromSuperview()
        }
        
        if vc.subModel?.trial != 1 {
            vc.subscribeView.fullPriceLabel.text =
            (vc.subModel?.type?.total?.description ?? "") + " \(Settings.currencyCym ?? "")"
        } else {
            vc.subscribeView.fullPriceLabel.removeFromSuperview()
        }
        
        vc.subscribeView.pricePerMonthLabel.text = "До: " + (vc.subModel?.expTime?.description.convertDate(to: 4) ?? "")
        
        if vc.subModel?.trial != 1 {
            vc.changeSubscriptionButton.isHidden = false
            vc.subscribeView?.intervalLabel.text = (vc.subModel?.type?.duration?.description ?? "") + (subMounth ?? "")
        } else {
            vc.changeSubscriptionButton.isHidden = true
            vc.subscribeView?.intervalLabel.text = "Пробная подписка 14 дней"
        }
    }
    
    func refuseTheSubscription() {
        
        let alert = UIAlertController(
            title: "Отменить подписку?",
            message: "После отмены подписка будет действительна до окончания оплаченного периода",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { (action: UIAlertAction!) in
            print("Да")
            SVProgressHUD.show()
            self.networkingLayer.refuseSub().subscribe() {
                SVProgressHUD.dismiss()
                self.presenter.backAction()
            }
        }
        ))
        
        alert.addAction(UIAlertAction(title: "Нет", style: .default, handler: { (action: UIAlertAction!) in
            print("Нет")
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
}
