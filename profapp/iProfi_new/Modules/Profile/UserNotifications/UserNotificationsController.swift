//
//  UserNotificationsController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 31.08.2021.
//

import UIKit

class UserNotificationsController: UIViewController, NotifAlertDelegate {
    
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var subPlate: UIView!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var margin: NSLayoutConstraint!

    
    var presenter: UserNotificationsPresenterProtocol!
    let configurator: UserNotificationsConfiguratorProtocol = UserNotificationsConfigurator()
    var clientNotifs: [ClientNotif] = []
    var userModel: UserModel?
    
    var dismissAfter: Bool?
    var client: Client?
    var message: String?
    var dismissAll: Bool? {
        didSet {
            if dismissAll ?? false {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    var notiId: Int?
    var needUpdate: Bool? {
        didSet {
            if needUpdate ?? false {
                presenter.setReaded()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        presenter.getReminders()
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func openSubs(_ sender: Any) {
        presenter.openSubs()
    }
    
    @IBAction func goToSettings() {
        presenter.openSettings()
    }
    
}

extension UserNotificationsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        clientNotifs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserNotificationsCell
        let obj = clientNotifs[indexPath.row]
        cell.configure(model: obj)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = clientNotifs[indexPath.row]
        notiId = obj.item?.id
        presenter.showAlert(model: obj)
    }
}
