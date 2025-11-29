//
//  ContactListController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 30.11.2020.
//

import UIKit
import Contacts

struct PhoneContact: Equatable {
    var firstName: String
    var lastName: String
    var telephone: String
    var id: String
}

class ContactListController: UIViewController {
    var presenter: ContactListPresenterProtocol!
    let configurator: ContactListConfiguratorProtocol = ContactListConfigurator()
    var delegate: ContactClientDelegate?
    var contacts: [PhoneContact] = []
    
    var namesList: [NamesModel] = [] {
        didSet {
            placeholderView.isHidden = !(namesList.count == 0)
        }
    }
    var namesListBuffer: [NamesModel] = []
    var selectedContacts: [PhoneContact] = [] {
        didSet {
            addMultipleContactsButton.isHidden = !(selectedContacts.count > 0)
        }
    }
    
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addMultipleContactsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            tableView.contentInset.bottom = keyboardHeight
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset = .zero
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func addMultipleContactsAction() {
        presenter.addMultipleContacts(selectedContacts: selectedContacts)
    }
    
    func filterElems(with string: String) {
        var contactsBuf: [PhoneContact] = []
        namesList = []
        contacts.forEach { (item) in
            if item.firstName.lowercased().contains(string.lowercased()) || item.lastName.lowercased().contains(string.lowercased()) || item.telephone.lowercased().contains(string.lowercased()) {
                contactsBuf.append(item)
            }
        }
        
        contactsBuf = contactsBuf.sorted { $0.firstName.lowercased() < $1.firstName.lowercased() }
        
        let groupedByFirst = Dictionary(grouping: contactsBuf) { $0.firstName.first }
        
        for (key, value) in groupedByFirst {
            let keyString = "\(key ?? String.Element(" "))"
            namesList.append(NamesModel(sectionTitle: keyString, names: value))
        }
        
        var sorted = namesList.sorted { $0.sectionTitle.lowercased() < $1.sectionTitle.lowercased() }
        
        if sorted.count > 0 {
            if sorted.contains(where: {$0.sectionTitle == "+"}) {
                let index = sorted.firstIndex(where: {$0.sectionTitle == "+"}) ?? 0
                sorted.append(sorted[index])
                sorted.remove(at: index)
            }
            
            if sorted.contains(where: {$0.sectionTitle == " "}) {
                let index = sorted.firstIndex(where: {$0.sectionTitle == " "}) ?? 0
                sorted.append(sorted[index])
                sorted[sorted.count - 1].sectionTitle = "0-9"
                sorted.remove(at: index)
            }
        }
        
        tableView.reloadData()
    }
}
 
extension ContactListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "header") as! ContactListHeader
        header.headerTitle.text = namesList[section].sectionTitle
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        namesList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        namesList[section].names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactListCell
   
        let id = namesList[indexPath.section].names[indexPath.row].id
        
        if let contact = contacts.first { $0.id == id } {
            
            let isSelected = selectedContacts.contains(contact)
            
            cell.configure(contact: contact, isSelected: isSelected)
            
            cell.onCheckBoxSelected = { [weak self] contact, isPhoneSelected in
                if isPhoneSelected {
                    self?.selectedContacts = self?.selectedContacts.filter { $0 != contact } ?? []
                    self?.selectedContacts.append(contact)
                } else {
                    self?.selectedContacts = self?.selectedContacts.filter { $0 != contact } ?? []
                }
            }
            
            cell.onContactErrorClick = {
                let alert = UIAlertController(title: "Недостаточно данных", message: "Для регистрации контакта через мультивыбор, необходимо, чтобы у контакта было имя и номер телефона", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: { action in
                }))
                self.present(alert, animated: true)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.contact = namesList[indexPath.section].names[indexPath.row]
        presenter.selectAction()
    }
}

extension ContactListController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: String(text)) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            
            print(namesList.count)
            
            if updatedText.count == 0 {
                namesList = namesListBuffer
                tableView.reloadData()
            } else {
                filterElems(with: updatedText)
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
