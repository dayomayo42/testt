//
//  ContactListInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 30.11.2020.
//

import Foundation
import UIKit
import Contacts
import Moya
import RxSwift
import SVProgressHUD

protocol ContactListInteractorProtocol: class {
    func configureView()
    func selectAction()
    func addMultipleContacts(selectedContacts: [PhoneContact] )
}

struct NamesModel {
    var sectionTitle : String!
    var names : [PhoneContact]!
}

class ContactListInteractor: ContactListInteractorProtocol {
    weak var viewController: ContactListController!
    weak var presenter: ContactListPresenterProtocol!
    
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    var namesList: [NamesModel] = []
    
    init(viewController: ContactListController, presenter: ContactListPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        guard let vc = viewController else { return }
        
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to request access", error)
                return
            }
            if granted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        self.viewController.contacts.append(PhoneContact(firstName: contact.givenName, lastName: contact.familyName, telephone: contact.phoneNumbers.first?.value.stringValue ?? "", id: UUID().uuidString))
                    })
                } catch let error {
                    print("Failed to enumerate contact", error)
                }
            } else {
                print("access denied")
            }
        }
        
        self.viewController.contacts = self.viewController.contacts.sorted { $0.firstName.lowercased() < $1.firstName.lowercased() }
        
        let groupedByFirst = Dictionary(grouping: self.viewController.contacts) { $0.firstName.first }
        
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
        
        self.viewController.namesList = sorted
        self.viewController.namesListBuffer = sorted
        self.viewController.tableView.reloadData()
        
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: vc.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        doneBtn.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        vc.searchField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction() {
        guard let vc = viewController else { return }
        vc.view.endEditing(true)
    }
    
    func addMultipleContacts(selectedContacts: [PhoneContact] ) {
        
        guard selectedContacts.count > 0 else { return }
        
        var clientModel: [CreateClientModel?] = []
        
        selectedContacts.forEach { contact in
            let client = CreateClientModel(name: contact.firstName,
                                           midname: "",
                                           lastname: contact.lastName,
                                           phone: contact.telephone,
                                           email: "",
                                           gender: "",
                                           birth: "",
                                           note: "",
                                           image: "")
            clientModel.append(client)
        }
        
        let createClientModelV3 = CreateClientModelV3(clients: clientModel)        
        
        SVProgressHUD.show()
        service.postCreateClient(model: createClientModelV3).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    NotificationCenter.default.post(name: NSNotification.Name.ClientsUpdate, object: nil, userInfo: nil)
                    if self.viewController.delegate != nil {
                        self.presenter.router.backAction()
                    } else {
                        SVProgressHUD.showError(withStatus: response.message)
                    }
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    
    func selectAction() {
        let vc = viewController.getControllerClients(controller: .addClient) as! AddClientController
//        vc.hidesBottomBarWhenPushed = true
        vc.delegate = viewController.delegate
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}




