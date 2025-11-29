//
//  ClientsInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol ClientsInteractorProtocol: class {
    func configureView()
    func clientsDetail(model: Client)
    func checkCacheClients()
    func getClients()
    func addClient()
    func choose(model: Client)
    func manualAddClient()
    func contactAddClient()
    func sortArray(with string: String)
    func multiChoose(clients: [Client])
}

class ClientsInteractor: ClientsInteractorProtocol {
    weak var viewController: ClientsController!
    weak var presenter: ClientsPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    let toolbar = UIToolbar()

    init(viewController: ClientsController, presenter: ClientsPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }

    func configureView() {
        if viewController.stockDelegate != nil ||  viewController.delegate != nil ||  viewController.editdelegate != nil {
            viewController.backButton.isHidden = false
        } else {
            viewController.backButton.isHidden = true
        }
        
        toolbar.sizeToFit()
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let comletionButton = UIBarButtonItem(title: "Готово", style: UIBarButtonItem.Style.plain, target: self, action: #selector(closeKeyboard))
        toolbar.setItems([spaceButton, comletionButton], animated: false)
        toolbar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        viewController.searchField.inputAccessoryView = toolbar
    }
    
    @objc func closeKeyboard() {
        viewController.view.endEditing(true)
    }
    
    func clientsDetail(model: Client) {
        let vc = viewController.getControllerClients(controller: .clientDetail) as! ClientDetailController
        vc.model = model
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkIfPlaceholderNeeded() {
        if viewController.clients.count != 0 {
            viewController.placeholderView.isHidden = true
        } else {
            viewController.placeholderView.isHidden = false
        }
    }
    
    func checkCacheClients() {
        guard let vc = viewController else { return }
        if let clients = vc.cache?.recordCache.clients?.data {
            self.sortBase(client: clients)
        } else {
            getClients()
        }
    }
    
    func getClients() {
        self.viewController.showHUD(show: true)
        self.service.getClients().subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.cache?.recordCache.clients = response
                    self.sortBase(client: response.data ?? [])
                } else {
                    self.checkIfPlaceholderNeeded()
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            self.checkIfPlaceholderNeeded()
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: self.disposeBag)
    }
    
    func sortBase(client: [Client]) {
        var clientArray = client
        
        let blocked = clientArray.filter({ $0.blocked ?? false })
        let waited = clientArray.filter({ $0.waited ?? false })
        clientArray.removeAll(where: { $0.blocked ?? false })
        clientArray.removeAll(where: { $0.waited ?? false })
        
        clientArray = clientArray.sorted {
            $0.status ?? 0 < $1.status ?? 0
        }
        
        for item in waited {
            clientArray.append(item)
        }
        
        for item in blocked {
            clientArray.append(item)
        }
        
        self.viewController.clients = clientArray
        self.viewController.bufferClients = self.viewController.clients
        checkIfPlaceholderNeeded()
        self.viewController.tableView.reloadData()
    }
    
    func addClient() {
        let vc = viewController.getControllerClients(controller: .addClientAlert) as! AddClientBottom
        vc.delegate = viewController
        viewController.present(vc, animated: true)
//        let vc = viewController.getControllerClients(controller: .addClient)
//        vc.hidesBottomBarWhenPushed = true
//        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func choose(model: Client) {
        if viewController.stockDelegate != nil {
            viewController.stockDelegate?.client = model
            viewController.navigationController?.popViewController(animated: true)
        }
    }


    func multiChoose(clients: [Client]) {
        if viewController.editdelegate != nil {
//            viewController.editdelegate?.model?.client = clients
        } else if viewController.delegate != nil {
            viewController.delegate?.model.client = clients
        }
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func manualAddClient() {
        let vc = viewController.getControllerClients(controller: .addClient)
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func contactAddClient() {
        let vc = viewController.getControllerClients(controller: .contactList) as! ContactListController
        vc.hidesBottomBarWhenPushed = true
        vc.delegate = viewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func sortArray(with string: String) {
        self.viewController.clients = []
        self.viewController.bufferClients.forEach { (client) in
            if "\(client.name ?? "") \(client.midname ?? "") \(client.lastname ?? "")".lowercased().contains(string.lowercased()) || "\(client.lastname ?? "") \(client.name ?? "") \(client.midname ?? "")".lowercased().contains(string.lowercased()) {
                self.viewController.clients.append(client)
            }
        }
        
        self.viewController.tableView.reloadData()
    }
}
