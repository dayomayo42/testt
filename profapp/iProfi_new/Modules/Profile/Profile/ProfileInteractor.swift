//
//  ProfileInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import Foundation
import Moya
import RxSwift
import SVProgressHUD
import UIKit

protocol ProfileInteractorProtocol: class {
    func configureView()
    func logoutAction()
    func productAction()
    func servicesAction()
    func getProfile()
    func fillView()
    var userModel: UserModel? { get set }
    func openDetail()
    func choosePhoto()
    func postPhoto()
    func openSupport()
    func openShedule()
    func openOnlineRecord()
    func shareApp()
    func openSettings()
    func openNotifications()
    func openNotificationSettings()
    func openReview()
    func openSubscription()
    func stockAction()
    func openUserNotification()
}

class ProfileInteractor: ProfileInteractorProtocol {
    var userModel: UserModel?
    weak var viewController: ProfileController!
    weak var presenter: ProfilePresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    var first = true

    init(viewController: ProfileController, presenter: ProfilePresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }

    func configureView() {
        if Settings.opennotification ?? false {
            Settings.opennotification = false
            openNotifications()
        } else if Settings.openNotice ?? false {
            Settings.openNotice = false
            openUserNotification()
        }
    }

    func logoutAction() {
        
        let alert = UIAlertController(
            title: "Выйти из аккаунта?",
            message: "Вы уверены, что хотите выйти из аккаунта?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { (action: UIAlertAction!) in
            print("Да")
            let vc = self.viewController.getController(controller: .launch)
            Authorization.token = nil
            Authorization.name = nil
            Authorization.id = nil
            
            Settings.calendar = false
            Settings.currency = nil
            Settings.currencyCym = nil
            Settings.onlinerecord = nil
            // viewController.present(vc, animated: true, completion: nil)
            UIApplication.shared.keyWindow?.rootViewController = NavigationController(rootViewController: vc)
        }))
        
        alert.addAction(UIAlertAction(title: "Нет", style: .default, handler: { (action: UIAlertAction!) in
            print("Нет")
            
        }))
        
        viewController.present(alert, animated: true, completion: nil)
    }

    func productAction() {
        let vc = viewController.getControllerProfile(controller: .products) as! ProductController
        vc.userModel = userModel
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    func servicesAction() {
        let vc = viewController.getControllerProfile(controller: .services)
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openSupport() {
        let vc = viewController.getControllerProfile(controller: .support)
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    func getProfile() {
        if first {
            self.viewController.showHUD(show: true)
            first = false
        }
        service.getProfile().subscribe { response in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.userModel = response.data
                    Settings.onlinerecord = response.data?.onlineRecord ?? 0
                    Authorization.useraddress = response.data?.address ?? ""
                    Authorization.name = response.data?.name
                    Authorization.midname = response.data?.midname
                    Authorization.lastame = response.data?.lastname
                    Authorization.email = response.data?.email
                    Settings.subType = response.data?.subscription?.type?.key
                    Settings.subId = response.data?.subscription?.type?.id
                    Settings.subTrialExp = response.data?.trialExp?.description
                    self.fillView()
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                    self.fillErrorMenu()
                }
            }

        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
            self.fillErrorMenu()
        }.disposed(by: disposeBag)
    }

    func fillView() {
        
        viewController.stackView.arrangedSubviews.forEach { optionButtonView in
            optionButtonView.isHidden = false
        }
        
        if userModel?.lastname?.count ?? 0 > 0 {
            viewController.nameLabel.text = "\(userModel?.lastname ?? "")\n\(userModel?.name ?? "") \(userModel?.midname ?? "")"
        } else {
            viewController.nameLabel.text = "\(userModel?.name ?? "")"
        }
        
        if userModel?.image != "" {
            viewController.avatarView.af_setImage(withURL: URL(string: (userModel?.image!)!)!, completion:  { [weak self] _ in
                self?.viewController.avatarIndicator.isHidden = true
                self?.viewController.avatarIndicator.stopAnimating()
            })
        } else {
            viewController.avatarView.image = #imageLiteral(resourceName: "Big")
            viewController.avatarIndicator.isHidden = true
            viewController.avatarIndicator.stopAnimating()
        }

        viewController.sphereLabel.text = userModel?.sphere?.name
        viewController.contentView.isHidden = false
        if userModel?.notifications ?? false {
            viewController.dotNotification.isHidden = false
        } else {
            viewController.dotNotification.isHidden = true
        }

        if userModel?.reminderClient ?? false {
            viewController.dotNotice.isHidden = false
        } else {
            viewController.dotNotice.isHidden = true
        }
        
        if userModel?.subscription != nil {
            let subName = userModel?.subscription?.type?.name?.uppercased() ?? ""
            let expTime = userModel?.subscription?.expTime ?? ""
            
            if userModel?.subscription?.trial == 1 {
                viewController.subscribeTitle.text = "Пробная подписка"
            } else {
                viewController.subscribeTitle.text = "Подписка"
            }
            
            viewController.subscribeDesc.isHidden = false
            viewController.subscribeDesc.text = "\(subName)"
            viewController.expSubscriptionTimeLabel.text = "До: \(expTime.convertDate(to: 4))"
        } else {
            viewController.subscribeDesc.isHidden = true
            viewController.expSubscriptionTimeLabel.text = "Перейдите на полную версию, чтобы пользоваться всеми функциями приложения."
        }
        
        if !(userModel?.notifications ?? false) && !(userModel?.reminderClient ?? false) {
            if let profileItem = viewController.tabBarController?.tabBar.items?.last {
                viewController.tabBarController?.removeRedDot()
            }
        }
    }
    
    func fillErrorMenu() {
        guard let vc = viewController else { return }
        vc.stackView.arrangedSubviews.forEach { optionButtonView in
            optionButtonView.isHidden = true
        }
        vc.stackView.arrangedSubviews.last?.isHidden = false
        vc.userInfo.isHidden = true
        
        vc.contentView.isHidden = false
    }
    
    func openDetail() {
        let vc = viewController.getControllerProfile(controller: .profiledetail) as! ProfileDetailController
        vc.userModel = userModel
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func choosePhoto() {
        let alert = UIAlertController(title: "Выберите изображение", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Камера", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { _ in
            self.openGallery()
        }))

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = viewController
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = false
                viewController.present(imagePicker, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "У вас нет камеры.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }

    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = viewController
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            viewController.present(imagePicker, animated: true, completion: nil)

        } else {
            let alert = UIAlertController(title: "Ошибка", message: "У вас нет доступа к галерее.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func postPhoto() {
        viewController.avatarIndicator.isHidden = false
        viewController.avatarIndicator.startAnimating()
        
        if viewController.photoURL != nil {
            service.postPhoto(url: viewController.photoURL!).subscribe { (response) in
                if self.viewController != nil {
                    if response.success ?? false {
                        self.userModel?.image = response.data?.url
                        self.fillView()
                        self.service.postEditedModel(model: self.userModel!).subscribe { (response) in
                            SVProgressHUD.dismiss()
                            if self.viewController != nil {
                                if response.success ?? false {
//                                    self.viewController.navigationController?.popViewController(animated: true)
                                } else {
                                    SVProgressHUD.showError(withStatus: response.message)
                                }
                            }
                        } onError: { (error) in
                            SVProgressHUD.showError(withStatus: error.localizedDescription)
                        }.disposed(by: self.disposeBag)
                    } else {
                        self.fillView()
                        SVProgressHUD.showError(withStatus: response.message)
                    }
                }
            } onError: { (error) in
                self.fillView()
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }.disposed(by: disposeBag)
        }
    }
    
    func openShedule() {
        let vc = viewController.getControllerProfile(controller: .shedule) as! SheduleController
        vc.hidesBottomBarWhenPushed = true
       // vc.userModel = userModel
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openOnlineRecord() {
        let vc = viewController.getControllerProfile(controller: .onlinerecords) as! OnlineRecordController
        vc.userModel = userModel
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func shareApp() {
        let shareText = "Рекомендую отличное приложение, которым пользуюсь лично. «ProffApp» - это личный помощник для специалистов и профессионалов своей сферы https://apps.apple.com/us/app/profapp-запись-клиентов-и-crm/id1553889063"
        let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
        viewController.present(vc, animated: true)
    }
    
    func openSettings() {
        let vc = viewController.getControllerProfile(controller: .settings)
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openNotifications() {
        let vc = viewController.getControllerProfile(controller: .notifications)
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openNotificationSettings() {
        let vc = viewController.getControllerProfile(controller: .notificationsettings)
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openReview() {
        let vc = viewController.getControllerProfile(controller: .review) as! ReviewController
        viewController.present(vc, animated: true)
    }
    
    func openSubscription() {
        if userModel?.subscription?.id == nil {
            let vc = viewController.getControllerProfile(controller: .subscription) as! NewSubscriptionController
            vc.hidesBottomBarWhenPushed = true
            viewController.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = viewController.getControllerProfile(controller: .subscriptionDetails) as! NewSubscriptionDetailsViewController
            vc.hidesBottomBarWhenPushed = true
            vc.subModel = userModel?.subscription
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func stockAction() {
        let vc = viewController.getControllerProfile(controller: .stock) as! StockController
        vc.userModel = userModel
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openUserNotification() {
        let vc = viewController.getControllerProfile(controller: .usernotif) as! UserNotificationsController
        vc.hidesBottomBarWhenPushed = true
        vc.userModel = userModel
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}

