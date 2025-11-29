//
//  NotificationDetailInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 03.12.2020.
//

import Foundation
import Moya
import RxSwift
import SVProgressHUD
import UIKit

protocol NotificationDetailInteractorProtocol: class {
    func configureView()
    func postAccept(id: Int)
    func postCancel(id: Int)
    func openPhone(with num: String)
    func editAction(with model: Records, type: RecordsType)
}

class NotificationDetailInteractor: NotificationDetailInteractorProtocol {
    weak var viewController: NotificationDetailController!
    weak var presenter: NotificationDetailPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()

    init(viewController: NotificationDetailController, presenter: NotificationDetailPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }

    func configureView() {
        let model = viewController.record

        if viewController.status == 0 {
            viewController.acceptButton.isHidden = false
            viewController.cancelButton.isHidden = false
            viewController.statusView.isHidden = true
            viewController.editButton.isHidden = false
        } else if viewController.status == 1 {
            viewController.acceptButton.isHidden = true
            viewController.cancelButton.isHidden = true
            viewController.statusView.isHidden = false
            viewController.statusLabel.text = "Запись подтверждена"
            viewController.statusLabel.textColor = #colorLiteral(red: 0, green: 0.8690080047, blue: 0.3919513524, alpha: 1)
            viewController.editButton.isHidden = true
        } else if viewController.status == 2 {
            viewController.acceptButton.isHidden = true
            viewController.cancelButton.isHidden = true
            viewController.statusView.isHidden = false
            viewController.statusLabel.text = "Запись отклонена"
            viewController.statusLabel.textColor = #colorLiteral(red: 0.9677701592, green: 0.230127275, blue: 0.2682518363, alpha: 1)
            viewController.editButton.isHidden = true
        }

        // TODO: переделать
        viewController.clientNameLabel.text = "\(model?.client?.first?.lastname ?? "") \(model?.client?.first?.name ?? "")"
        viewController.phoneLabel.text = model?.client?.first?.phone
        viewController.dateLabel.text = model?.date
        viewController.cometLabel.text = model?.note

        viewController.priceLabel.text = model?.price?.getFormatedPrice()
        viewController.timeLabel.text = "\(model?.duration ?? 0) мин."

        for item in viewController.serviceStack.arrangedSubviews {
            viewController.serviceStack.removeArrangedSubview(item)
        }
        
        for index in 0 ... ((model?.services?.count ?? 0) - 1) {
            let item = model?.services?[index]
            let view = ServiceInfoView()
            view.titleLabel.text = item?.name ?? ""
            view.durationLabel.text = "\(item?.duration ?? 0) мин."
            view.priceLabel.text = item?.price?.getFormatedPrice()
            if index == ((model?.services?.count ?? 0) - 1) {
                view.separatorLabel.isHidden = true
            } else {
                view.separatorLabel.isHidden = false
            }
            viewController.serviceStack.addArrangedSubview(view)
        }
    }

    func postAccept(id: Int) {
        SVProgressHUD.show()
        service.postAcceptRecord(id: id).subscribe { response in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.navigationController?.popViewController(animated: true)
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }

    func postCancel(id: Int) {
        SVProgressHUD.show()
        service.postCancelRecord(id: id).subscribe { response in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.navigationController?.popViewController(animated: true)
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }

    func openPhone(with num: String) {
        if let url = URL(string: "tel://\("\(num)")") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

    func editAction(with model: Records, type: RecordsType) {
        viewController.showHUD(show: true)
        service.getRecords().subscribe { response in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    let vc = self.viewController.getControllerRecord(controller: .recorddetail) as! RecordDetailController
                    vc.model = model
                    vc.fromNotific = true
                    vc.hidesBottomBarWhenPushed = true
                    vc.type = .future
                    vc.notificationDelegate = self.viewController
                    vc.records = response.data ?? []
                    self.viewController.navigationController?.pushViewController(vc, animated: true)
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}
