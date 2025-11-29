//
//  RecordsSearchController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.10.2020.
//

import UIKit

class RecordsSearchController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchField: UITextField!
    @IBOutlet var clearButton: UIButton!
    @IBOutlet weak var placeholderView: UIView!
    
    var presenter: RecordsSearchPresenterProtocol!
    let configurator: RecordsSearchConfiguratorProtocol = RecordsSearchConfigurator()
    
    var allRecords: [Records] = []
    
    let debouncer = Debouncer(timeInterval: 0.35)
    
    var records: [Records] = [] {
        didSet {
            tableView.reloadData()
            tableView.isHidden = !(records.count > 0)
            placeholderView.isHidden = records.count > 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }

    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }

    @IBAction func clearAction(_ sender: Any) {
        presenter.clearField()
    }
}

extension RecordsSearchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecordCell
        cell.configure(with: records[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = getControllerRecord(controller: .recorddetail) as! RecordDetailController
        let currentDate = Date().getCurrentGmtDate()
        let model = records[indexPath.row]
        vc.model = model
        vc.records = records
        
        if model.date?.convertDateToDate().timeIntervalSince1970 ?? 0 > currentDate.timeIntervalSince1970 {
            // будет
            vc.type = .future
            if model.status == 1 {
                vc.type = .cancelled
            }
        } else if Int(currentDate.timeIntervalSince1970 - (model.date?.convertDateToDate().timeIntervalSince1970 ?? 0)) < (model.duration ?? 0) * 60 {
            // в процессе
            if model.status == 0 {
                vc.type = .now
            } else if model.status == 1 {
                vc.type = .cancelled
            }
        } else {
            // завершено
            vc.type = .ended
            if model.status == 1 {
                vc.type = .cancelled
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension RecordsSearchController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 370, right: 0)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: String(text)) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            presenter.showClearButton(from: updatedText)
            presenter.searchByString(string: updatedText)
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
