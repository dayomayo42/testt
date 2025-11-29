//
//  NotificationsController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.12.2020.
//

import UIKit

class NotificationsController: UIViewController {

    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var sortedNotifications: [[Notification]] = []
    var presenter: NotificationsPresenterProtocol!
    let configurator: NotificationsConfiguratorProtocol = NotificationsConfigurator()
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter.getNotification()
    }
    
    @IBAction func backActio(_ sender: Any) {
        presenter.backAction()
    }
    
    @objc func acceptAction(_ recognizer: NotificationRecognizer) {
        if let id = recognizer.headline {
            presenter.postAccept(id: id)
        }
    }
    
    @objc func cancelAction(_ recognizer: NotificationRecognizer) {
        if let id = recognizer.headline {
            presenter.postCancel(id: id)
        }
    }
}

extension NotificationsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "header") as! NotificationHeaderCell
        header.dateLabel.text = "\(sortedNotifications[section].first?.createdAt?.split(separator: "T").first ?? "")".convertDate(to: 1)
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sortedNotifications.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sortedNotifications[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotificationCell
        cell.configure(model: sortedNotifications[indexPath.section][indexPath.row], vc: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = sortedNotifications[indexPath.section][indexPath.row]
        if obj.confirmed != 3 {
            presenter.openDetail(record: obj.record!, status: obj.confirmed ?? 0)
        }
    }
}


class NotificationRecognizer: UITapGestureRecognizer {
    var headline: Int?
}
