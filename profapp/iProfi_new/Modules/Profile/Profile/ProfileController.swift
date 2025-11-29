//
//  ProfileController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import UIKit
import SVProgressHUD

class ProfileController: UIViewController {
    var presenter: ProfilePresenterProtocol!
    let configurator: ProfileConfiguratorProtocol = ProfileConfigurator()
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var dotNotice: UIView!
    @IBOutlet weak var dotNotification: UIView!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sphereLabel: UILabel!
    @IBOutlet weak var userInfo: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var subscribeTitle: UILabel!
    @IBOutlet weak var subscribeDesc: UILabel!
    @IBOutlet weak var expSubscriptionTimeLabel: UILabel!
    @IBOutlet weak var avatarIndicator: UIActivityIndicatorView!
    
    var isFromCamera = false
    
    var photoURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if !isFromCamera {
            presenter.getProfile()
        } else {
            isFromCamera = false
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        SVProgressHUD.dismiss()
    }
    
    @IBAction func reviewAction(_ sender: Any) {
        presenter.openReview()
    }
    
    @IBAction func notificationsAction(_ sender: Any) {
        presenter.openNotifications()
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        presenter.logoutAction()
    }
    
    @IBAction func productAction(_ sender: Any) {
        presenter.productAction()
    }
    
    @IBAction func profileDetailAction(_ sender: Any) {
        presenter.openDetail()
    }
    
    @IBAction func servicesAction(_ sender: Any) {
        presenter.servicesAction()
    }
    
    @IBAction func changeAvatar(_ sender: Any) {
        presenter.choosePhoto()
    }
    
    @IBAction func supportActtion(_ sender: Any) {
        presenter.openSupport()
    }
    
    @IBAction func settingsAction(_ sender: Any) {
        presenter.openSettings()
    }
    
    @IBAction func shedule(_ sender: Any) {
        presenter.openShedule()
    }
    
    @IBAction func onlineRecord(_ sender: Any) {
        presenter.openOnlineRecord()
    }
    
    @IBAction func shareAction(_ sender: Any) {
        presenter.shareApp()
    }
    
    @IBAction func notificationSettings(_ sender: Any) {
        presenter.openNotificationSettings()
    }
    
    @IBAction func subscribeAction(_ sender: Any) {
        presenter.openSubscription()
    }
    
    @IBAction func stockAction(_ sender: Any) {
        presenter.stockAction()
    }
    
    @IBAction func userNotificationAction(_ sender: Any) {
        presenter.openUserNotification()
    }
    
}

extension ProfileController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        if let url = info[.imageURL] as? URL {
            avatarView.image = nil
            photoURL = url
            presenter.postPhoto()
        } else if let img = info[.originalImage] as? UIImage {
            img.saveToCameraRoll { url in
                if let url = url {
                    self.avatarView.image = nil
                    self.photoURL = url
                    self.presenter.postPhoto()
                }
            }
        }
        self.isFromCamera = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isFromCamera = true
        picker.dismiss(animated: true, completion: nil)
    }
}
