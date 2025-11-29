//
//  NotificationSettingsDetailController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 09.12.2020.
//

import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol NotificationTimeDelegate: class {
    var notificationSettings: [NotificationSettings] {get set}
    var indexArr: Int {get set}
    var displayTime: String {get set}
}

class NotificationSettingsDetailController: UIViewController, NotificationTimeDelegate {
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    var type: NotificationsType?
    var notificationSettings: [NotificationSettings] = []
    var indexArr: Int = 0
    
    let list: [RecordsNotifTypeModel] = [RecordsNotifTypeModel(name: "1 день", serverName: 1), RecordsNotifTypeModel(name: "3 дня", serverName: 48), RecordsNotifTypeModel(name: "1 неделя", serverName: 7), RecordsNotifTypeModel(name: "2 недели", serverName: 14), RecordsNotifTypeModel(name: "3 недели", serverName: 21), RecordsNotifTypeModel(name: "1 месяц", serverName: 30)]
    var displayTime: String = "" {
        didSet {
            notifyTimeButton.setTitle(displayTime, for: .normal)
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var aboutNotyText: UIView!
    @IBOutlet weak var notifyTime: UIView!
    @IBOutlet weak var notifyTimeButton: UIButton!
    
    @IBOutlet weak var notifyTextLabel: UILabel!
    @IBOutlet weak var switchView: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillView()
    }
    
    func fillView() {
        var model: NotificationSettings?
        switch type {
        case .aboutMe:
            aboutNotyText.isHidden = false
            notifyTime.isHidden = false
            titleLabel.text = "Напоминание о себе"
            indexArr = notificationSettings.firstIndex(where: {$0.type == "aboutme"}) ?? 0
            displayTime = list.first(where: {$0.serverName == (notificationSettings[indexArr].remindAfter ?? 0)})?.name ?? ""
            if displayTime == "" {
                displayTime = list.first?.name ?? ""
                notificationSettings[indexArr].remindAfter = list.first?.serverName
            }
        case .cancelRecord:
            aboutNotyText.isHidden = true
            notifyTime.isHidden = true
            titleLabel.text = "Отмена записи"
            indexArr = notificationSettings.firstIndex(where: {$0.type == "cancel"}) ?? 0
        case .changeRecord:
            aboutNotyText.isHidden = true
            notifyTime.isHidden = true
            titleLabel.text = "Изменение записи"
            indexArr = notificationSettings.firstIndex(where: {$0.type == "update"}) ?? 0
        case .createRecord:
            aboutNotyText.isHidden = true
            notifyTime.isHidden = true
            titleLabel.text = "О создании записи"
            indexArr = notificationSettings.firstIndex(where: {$0.type == "create"}) ?? 0
        case .dayToMeet:
            aboutNotyText.isHidden = true
            notifyTime.isHidden = true
            titleLabel.text = "За 24 часа до сеанса"
            indexArr = notificationSettings.firstIndex(where: {$0.type == "24hours"}) ?? 0
        default: break
        }
        model = notificationSettings[indexArr]
        notifyTextLabel.text = model?.text
        switchView.isOn = model?.enabled ?? false
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        notificationSettings[indexArr].enabled = switchView.isOn
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendAction(_ sender: Any) {
        postEdited()
    }
    @IBAction func notifyTimeAction(_ sender: Any) {
        let vc = self.getControllerProfile(controller: .notificationties) as! TimeAlertController
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func notifyViewAction(_ sender: Any) {
        let vc = self.getControllerProfile(controller: .notificationties) as! TimeAlertController
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func postEdited() {
        SVProgressHUD.show()
        service.postNotificationSettings(list: NotificationSettingsPost(reminders: notificationSettings)).subscribe { (response) in
            SVProgressHUD.dismiss()
            if response.success ?? false {
                self.navigationController?.popViewController(animated: true)
            } else {
                SVProgressHUD.showError(withStatus: response.message)
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)

    }
}
