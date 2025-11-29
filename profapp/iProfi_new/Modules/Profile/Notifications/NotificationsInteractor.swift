//
//  NotificationsInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.12.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol NotificationsInteractorProtocol: class {
    func configureView()
    func getNotification()
    func postAccept(id: Int)
    func postCancel(id: Int)
    func sortNotifications(notifications: [Notification])
    func openDetail(record: Records, status: Int)
}

class NotificationsInteractor: NotificationsInteractorProtocol {
    weak var viewController: NotificationsController!
    weak var presenter: NotificationsPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    var first = true
    
    init(viewController: NotificationsController, presenter: NotificationsPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        viewController.tableView.contentInset.top = 8
    }
    
    func sortNotifications(notifications: [Notification]) {
        var sortedNotifications: [[Notification]] = []
        var bufferArray: [Notification] = []
        var lastDate = ""
        for item in notifications {
            let currentDate = "\(item.createdAt?.split(separator: "T").first ?? "")"
            if lastDate == "" {
                lastDate = currentDate
            }
            if currentDate == lastDate {
                bufferArray.append(item)
            } else {
                sortedNotifications.append(bufferArray)
                bufferArray = []
                bufferArray.append(item)
            }
            lastDate = currentDate
        }
        sortedNotifications.append(bufferArray)
        viewController.sortedNotifications = sortedNotifications
        checkIfPlaceholderNeeded()
        viewController.tableView.reloadData()
    }
    
    func postAccept(id: Int) {
        SVProgressHUD.show()
        service.postAcceptRecord(id: id).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.getNotification()
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func postCancel(id: Int) {
        SVProgressHUD.show()
        service.postCancelRecord(id: id).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.getNotification()
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func checkIfPlaceholderNeeded() {
        if viewController.sortedNotifications.count != 0 {
            viewController.placeholderView.isHidden = true
        } else {
            viewController.placeholderView.isHidden = false
        }
    }
    
    func getNotification() {
        if first {
            self.viewController.showHUD(show: true)
            first = false
        }
        service.getNotifications().subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    if response.data?.count ?? 0 > 0 {
                        self.sortNotifications(notifications: response.data ?? [])
                    } else {
                        self.checkIfPlaceholderNeeded()
                    }
                } else {
                    self.checkIfPlaceholderNeeded()
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            self.checkIfPlaceholderNeeded()
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)

    }
    
    func openDetail(record: Records, status: Int) {
        let vc = viewController.getControllerProfile(controller: .notificationdetail) as! NotificationDetailController
        vc.record = record
        vc.status = status
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}


