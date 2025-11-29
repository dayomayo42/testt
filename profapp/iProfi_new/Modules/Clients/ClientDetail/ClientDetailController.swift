//
//  ClientDetailController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.10.2020.
//

import UIKit

enum ClientStatus {
    case active
    case waiting
    case blocked
}

protocol ClientChangeStatusDelegate: class {
    var status: ClientStatus? {get set}
}

class ClientDetailController: UIViewController, ClientChangeStatusDelegate {
    var presenter: ClientDetailPresenterProtocol!
    let configurator: ClientDetailConfiguratorProtocol = ClientDetailConfigurator()
    var headerView: ClientDetailHeaderCell?
    var model: Client?
    
    var status: ClientStatus? {
        didSet {
            switch status {
            case .active:
                headerView?.statusLabel.text = "Активный"
                model?.waited = false
                model?.blocked = false
            case .waiting:
                headerView?.statusLabel.text = "Лист ожидания"
                model?.waited = true
                model?.blocked = false
            case .blocked:
                headerView?.statusLabel.text = "Заблокирован"
                model?.waited = false
                model?.blocked = true
            case .none:
                break
            }
            presenter.editUser()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    var photoURL: URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.getClient()
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func editAction(_ sender: Any) {
        presenter.editAction()
    }
    
    @objc func changePhoto() {
        presenter.choosePhoto()
    } 
    
    @objc func addClientRecord() {
        presenter.addClientRecord()
    }
    
    @objc func callAction() {
        presenter.callAction(num: model?.phone ?? "")
    }
    
    @objc func changeStatus() {
        presenter.changeStatus()
    }
}
 
extension ClientDetailController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if headerView == nil {
            let header = tableView.dequeueReusableCell(withIdentifier: "header") as! ClientDetailHeaderCell
            self.headerView = header
        }
        
        headerView?.configure(with: model!)
        headerView?.userAvatarView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.changePhoto)))
        headerView?.callButton.addTarget(self, action: #selector(self.callAction), for: .touchUpInside)
        headerView?.createRecordButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.addClientRecord)))
        headerView?.statusPlate.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.changeStatus)))
        
        if model?.blocked ?? false {
            headerView?.statusLabel.text = "Заблокирован"
        } else if model?.waited ?? false {
            headerView?.statusLabel.text = "Лист ожидания"
        } else {
            headerView?.statusLabel.text = "Активен"
        }
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.records?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ClientDetailRecordsCell
        cell.configure(model: (model?.records?[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openRecord(model: (model?.records?[indexPath.row])!)
    }
}

extension ClientDetailController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        if let url = info[.imageURL] as? URL {
            photoURL = url
        } else if let img = info[.originalImage] as? UIImage {
            img.saveToCameraRoll { url in
                if let url = url {
                    self.photoURL = url
                }
            }
        }
        headerView?.userAvatarView.image = image
        presenter.postPhoto()
        picker.dismiss(animated: true, completion: nil)
    }
}
