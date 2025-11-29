//
//  RecordsNotificController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 26.10.2020.
//

import UIKit

struct RecordsNotifTypeModel {
    var name: String?
    var serverName: Int?
}

class RecordsNotificAlert: UIViewController {
    @IBOutlet weak var background: UIView!
    var link: String = ""
    var delegate: RecordProtocol?
    var editdelegate: RecordEditProtocol?
    var client: Bool?
    
    let list: [RecordsNotifTypeModel] = [RecordsNotifTypeModel(name: "Не напоминать", serverName: 0), RecordsNotifTypeModel(name: "За 15 минут", serverName: 15), RecordsNotifTypeModel(name: "За 30 минут", serverName: 30), RecordsNotifTypeModel(name: "За 45 минут", serverName: 45), RecordsNotifTypeModel(name: "За 1 час", serverName: 60), RecordsNotifTypeModel(name: "За 2 часа", serverName: 120), RecordsNotifTypeModel(name: "За 1 день", serverName: 1440)]
    
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

extension RecordsNotificAlert: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecordsNotificCell
        cell.nameLabel.text = list[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if editdelegate != nil {
            
            if client ?? false {
                editdelegate?.clientNotificTime = list[indexPath.row]
                editdelegate?.presenter.configureView(with: (editdelegate?.model)!)
            } else {
                editdelegate?.notificTime = list[indexPath.row]
                editdelegate?.presenter.configureView(with: (editdelegate?.model)!)
            }
        } else {
            if client ?? false {
                delegate?.model.clientNotificTime = list[indexPath.row]
                delegate?.presenter.configureView(with: delegate!.model)
            } else {
                delegate?.model.notificTime = list[indexPath.row]
                delegate?.presenter.configureView(with: delegate!.model)
            }
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}

