//
//  RecordsServiceController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 26.10.2020.
//

import UIKit

class RecordsServiceController: UIViewController {
    @IBOutlet weak var placeholderView: UIView!
    var presenter: RecordsServicePresenterProtocol!
    let configurator: RecordsServiceConfiguratorProtocol = RecordsServiceConfigurator()
    var services: [Service] = []
    var servicesBuffer: [Service] = []
    var delegate: RecordProtocol?
    var editdelegate: RecordEditProtocol?
    var cache: RecordEntityCacheProtocol?
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        
        presenter.checkCacheServices()
        NotificationCenter.default.addObserver(self, selector: #selector(onUpdate), name: NSNotification.Name.ServicesUpdate, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.ServicesUpdate, object: nil)
    }
    
    @objc func onUpdate() {
        presenter.getServices()
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func addAction(_ sender: Any) {
        presenter.addService()
    }
    
    @IBAction func doneAction(_ sender: Any) {
        presenter.chooseService()
    }
}

extension RecordsServiceController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecordsServiceCell
//        if tableView.indexPathsForSelectedRows?.contains(indexPath) ?? false {
//            cell.checkedView.isHidden = false
//        } else {
//            cell.checkedView.isHidden = true
//        }
        
        cell.isSelected = services[indexPath.row].isSelected
        
        cell.configure(with: services[indexPath.row])
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RecordsServiceCell
        cell.checkedView.isHidden = false
        services[indexPath.row].isSelected = true
        let ind = servicesBuffer.firstIndex(where: {$0.id == services[indexPath.row].id}) ?? 0
        servicesBuffer[ind].isSelected = true
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.indexPathsForVisibleRows?.contains(indexPath) ?? false {
            let cell = tableView.cellForRow(at: indexPath) as! RecordsServiceCell
            cell.checkedView.isHidden = true
        }
        
        services[indexPath.row].isSelected = false
        let ind = servicesBuffer.firstIndex(where: {$0.id == services[indexPath.row].id}) ?? 0
        servicesBuffer[ind].isSelected = false
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let selectedRows = tableView.indexPathsForSelectedRows?.filter({ $0.section == indexPath.section }) {
            if selectedRows.count == 3 {
                let alert = UIAlertController(title: "", message: "Можно использовать только 3 услуги на одном заказе", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: { action in
                }))
                self.present(alert, animated: true)
                return nil
            }
        }
        return indexPath
    }
}


extension RecordsServiceController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tableView.contentInset.bottom = 380
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        tableView.contentInset.bottom = 0
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: String(text)) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            if updatedText.count > 0 {
                presenter.search(string: updatedText)
            } else {
                services = servicesBuffer
                self.tableView.reloadData()
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
