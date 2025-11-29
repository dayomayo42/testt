//
//  TimeAlertController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 10.12.2020.
//

import UIKit

class TimeAlertController: UIViewController {
    @IBOutlet weak var background: UIView!
    var link: String = ""
    var delegate: NotificationTimeDelegate?
    
    let list: [RecordsNotifTypeModel] = [RecordsNotifTypeModel(name: "1 день", serverName: 1), RecordsNotifTypeModel(name: "3 дня", serverName: 48), RecordsNotifTypeModel(name: "1 неделя", serverName: 7), RecordsNotifTypeModel(name: "2 недели", serverName: 14), RecordsNotifTypeModel(name: "3 недели", serverName: 21), RecordsNotifTypeModel(name: "1 месяц", serverName: 30)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseInOut, animations: {
            self.background.alpha = 1
        }, completion: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseOut, animations: {
            self.background.alpha = 0
        }, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension TimeAlertController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecordsNotificCell
        cell.nameLabel.text = list[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.notificationSettings[delegate?.indexArr ?? 0].remindAfter = list[indexPath.row].serverName
        delegate?.displayTime = list[indexPath.row].name ?? ""
        self.dismiss(animated: true, completion: nil)
    }
    
}
