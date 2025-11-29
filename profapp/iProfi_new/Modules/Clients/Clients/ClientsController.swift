//
//  ClientsController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import UIKit
import SVProgressHUD

protocol ContactClientDelegate {
    var contact: PhoneContact? {get set}
    var fromVC: ClientsController? {get set}
}


protocol ClientDelegate {
    var type: AddClientType? { get set }
}

class ClientsController: UIViewController, ClientDelegate, ContactClientDelegate {
    
    @IBOutlet weak var multiChoiceSelectView: UIView!
    
    @IBOutlet weak var placeholderView: UIView!
    
    @IBOutlet weak var multipleSelectButton: UIButton!
    
    var contact: PhoneContact?
    
    var fromVC: ClientsController?
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var clearImageView: UIImageView!
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var clearSearchView: UIView!
    
    var presenter: ClientsPresenterProtocol!
    let configurator: ClientsConfiguratorProtocol = ClientsConfigurator()
    var clients: [Client] = []
    var bufferClients: [Client] = []
    var header: ClientsHeaderCell?
    var delegate: RecordProtocol?
    var editdelegate: RecordEditProtocol?
    var stockDelegate: StockDelegate?
    var cache: RecordEntityCacheProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    var type: AddClientType? {
        didSet {
            switch type {
            case .contact:
                presenter.contactAddClient()
            case .manual:
                presenter.manualAddClient()
            default: break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()
        presenter.checkCacheClients()
        fromVC = self
        view.bringSubviewToFront(clearImageView)
        
        if cache != nil {
            tableView.allowsMultipleSelection = true
        } else {
            tableView.allowsMultipleSelection = false
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(onUpdate), name: NSNotification.Name.ClientsUpdate, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        SVProgressHUD.dismiss()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.ClientsUpdate, object: nil)
    }
    
    func onRowMultipleSelect() {
        let selectedCount = tableView.indexPathsForSelectedRows?.count ?? 0
        
        multiChoiceSelectView.isHidden = selectedCount > 0 ? false : true
        self.tableView.contentInset = selectedCount > 0 ? UIEdgeInsets(top: 0, left: 0, bottom: multiChoiceSelectView.frame.height + 16.0, right: 0) : UIEdgeInsets.zero
        
        multipleSelectButton.setTitle("Выбрать \(selectedCount) \(CountWords.word(for: selectedCount, from: ["контакт", "контакта", "контактов"])) " , for: .normal)
    }
    
    @objc func onUpdate() {
        presenter.getClients()
    }
    
    @IBAction func multiChooseAction() {
        var clientsArr: [Client] = []
        
        tableView.indexPathsForSelectedRows?.forEach({ indexPath in
            clientsArr.append(clients[indexPath.row])
        })
        
        presenter.multiChoose(clients: clientsArr)
    }
    
    @IBAction func backACtion(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func addAction(_ sender: Any) {
//        fetchContacts()
        presenter.addClient()
    }
    @IBAction func clearSearch(_ sender: Any) {
        searchField.text = ""
        
        clearSearchView.isHidden = true
        clients = bufferClients
        tableView.reloadData()
    }
}

extension ClientsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        clients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ClientsCell
        if cache != nil {
            cell.isMultipleSelectActive = true
        }
        cell.configure(with: clients[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if cache != nil {
            onRowMultipleSelect()
        } else if delegate != nil || editdelegate != nil || stockDelegate != nil  {
            presenter.choose(model: clients[indexPath.row])
        } else {
            presenter.clientsDetail(model: clients[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if cache != nil {
            onRowMultipleSelect()
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        let numOfSelectedRows = tableView.indexPathsForSelectedRows?.count ?? 0
        let limit = 5
        
        if numOfSelectedRows + 1 > limit {
            return nil
        }

        return indexPath
    }
}


extension ClientsController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tableView.contentInset.bottom = 380
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        tableView.contentInset.bottom = 0
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: String(text)) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            if updatedText.withoutSpaces().count > 0 {
                clearSearchView.isHidden = false
                presenter.sortArray(with: updatedText)
                
            } else {
                clearSearchView.isHidden = true
                clients = bufferClients
                tableView.reloadData()
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
