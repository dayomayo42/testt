//
//  NotificationSettingsInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 09.12.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol NotificationSettingsInteractorProtocol: class {
    func configureView()
    func openDetail(with type: NotificationsType)
    func getSettings()
    
    func configureView(list: [NotificationSettings])
}

class NotificationSettingsInteractor: NotificationSettingsInteractorProtocol {
    weak var viewController: NotificationSettingsController!
    weak var presenter: NotificationSettingsPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    var first = true
    
    init(viewController: NotificationSettingsController, presenter: NotificationSettingsPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
    }
    
    func configureView(list: [NotificationSettings]) {
        let about = list.first(where: {$0.type == "aboutme"})
        viewController.aboutMeStatus.text = about?.enabled ?? false ? "Вкл" : "Выкл"
        
        let day = list.first(where: {$0.type == "24hours"})
        viewController.dayToMeetStatus.text = day?.enabled ?? false ? "Вкл" : "Выкл"
        
        let create = list.first(where: {$0.type == "create"})
        viewController.createRecordsStatus.text = create?.enabled ?? false ? "Вкл" : "Выкл"
        
        let update = list.first(where: {$0.type == "update"})
        viewController.changeRecordsStatus.text = update?.enabled ?? false ? "Вкл" : "Выкл"
        
        let cancel = list.first(where: {$0.type == "cancel"})
        viewController.cancelRecordStatus.text = cancel?.enabled ?? false ? "Вкл" : "Выкл"
    }
    
    
    
    func openDetail(with type: NotificationsType) {
        let vc = viewController.getControllerProfile(controller: .notificationsettingsdetail) as! NotificationSettingsDetailController
        vc.type = type
        vc.notificationSettings = viewController.notificationSettings
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getSettings() {
        if first {
            self.viewController.showHUD(show: true)
            first = false
        }
        service.getNotificationSettings().subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.notificationSettings = response.data ?? []
                    self.configureView(list: response.data ?? [])
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)

    }
}


