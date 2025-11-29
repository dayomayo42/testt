//
//  NotificationSettingsController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 09.12.2020.
//

import UIKit

enum NotificationsType {
    case dayToMeet
    case createRecord
    case changeRecord
    case cancelRecord
    case aboutMe
}

class NotificationSettingsController: UIViewController {
    @IBOutlet weak var dayToMeetStatus: UILabel!
    @IBOutlet weak var createRecordsStatus: UILabel!
    @IBOutlet weak var changeRecordsStatus: UILabel!
    @IBOutlet weak var cancelRecordStatus: UILabel!
    @IBOutlet weak var aboutMeStatus: UILabel!
    var notificationSettings: [NotificationSettings] = []
    
    var presenter: NotificationSettingsPresenterProtocol!
    let configurator: NotificationSettingsConfiguratorProtocol = NotificationSettingsConfigurator()
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.getSettings()
    }

    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func dayToMeetAction(_ sender: Any) {
        presenter.openDetail(with: .dayToMeet)
    }
    
    @IBAction func createAction(_ sender: Any) {
        presenter.openDetail(with: .createRecord)
    }
    
    @IBAction func changeActoin(_ sender: Any) {
        presenter.openDetail(with: .changeRecord)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        presenter.openDetail(with: .cancelRecord)
    }
    
    @IBAction func aboutAction(_ sender: Any) {
        presenter.openDetail(with: .aboutMe)
    }
}
