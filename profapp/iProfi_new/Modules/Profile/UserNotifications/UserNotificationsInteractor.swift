//
//  UserNotificationsInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 31.08.2021.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol UserNotificationsInteractorProtocol {
    func configureView()
    func showAlert(model: ClientNotif)
    func getReminders()
    func setReaded()
}

class UserNotificationsInteractor: UserNotificationsInteractorProtocol {
    var viewController: UserNotificationsController!
    var presenter: UserNotificationsPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: UserNotificationsController, presenter: UserNotificationsPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        if (Settings.subType == "manager") || (Settings.subType == "premium") {
            viewController.settingButton.isHidden = false
            viewController.subPlate.isHidden = true
            viewController.tableView.isHidden = false
        } else {
            viewController.settingButton.isHidden = true
            viewController.subPlate.isHidden = false
            viewController.tableView.isHidden = true
        }
    }
    
    func showAlert(model: ClientNotif) {
        // TODO: переделать
        
        guard model.item?.client?.count ?? 0 == 1, let client = model.item?.client?.first else {
            return
        }
        
        let vc = viewController.getControllerProfile(controller: .notifalert) as! UserNotificationAlert
        vc.delegate = viewController
        viewController.dismissAfter = false

        var services = ""//"\(recModel?.services?.first?.name)"
        for item in model.item?.services ?? [] {
            services += ", \(item.name ?? "")"
        }

        let servs = services.dropFirst(2)
        var message = "Здравствуйте! Напоминаю, Вы записаны на: \(servs), \(model.item?.date ?? "")."
        if (Authorization.useraddress?.count ?? 0) > 0 {
            message += " Адрес: \(Authorization.useraddress ?? "")."
        }

        message += " Подтвердите, пожалуйста, свою запись. Ваш специалист: \(Authorization.lastame ?? "") \(Authorization.name ?? "")."

        viewController.message = message

        viewController.client = client
        viewController.present(vc, animated: true)
    }
    
    func getReminders() {
        if self.viewController.clientNotifs.count == 0 {
            SVProgressHUD.show()
        }
        
        service.getReminders().subscribe { response in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                self.viewController.clientNotifs = response.data?.reversed() ?? []
                self.checkIfPlaceholderNeeded()
                self.viewController.tableView.reloadData()
            }
        } onError: { error in
            self.checkIfPlaceholderNeeded()
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)

    }
    
    func checkIfPlaceholderNeeded() {
        if viewController.clientNotifs.count != 0 {
            viewController.placeholderView.isHidden = true
        } else if viewController.subPlate.isHidden == true {
            viewController.placeholderView.isHidden = false
        }
    }
    
    func setReaded() {
      //  SVProgressHUD.show() 
        service.getReadNotif(id: viewController.notiId ?? 0).subscribe { response in
            SVProgressHUD.dismiss()
            if response.success ?? false {
                self.getReminders()
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)

    }
}


