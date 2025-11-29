//
//  RecordsServiceInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 26.10.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol RecordsServiceInteractorProtocol: class {
    func configureView()
    func checkCacheServices()
    func getServices()
    func addService()
    func chooseService()
    func search(string: String)
}

class RecordsServiceInteractor: RecordsServiceInteractorProtocol {
    weak var viewController: RecordsServiceController!
    weak var presenter: RecordsServicePresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: RecordsServiceController, presenter: RecordsServicePresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let comletionButton = UIBarButtonItem(title: "Готово", style: UIBarButtonItem.Style.plain, target: self, action: #selector(completionDatePickerAction))
        toolbar.setItems([spaceButton, comletionButton], animated: false)
        toolbar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        viewController.searchField.inputAccessoryView = toolbar
    }
    
    @objc func completionDatePickerAction() {
        self.viewController.view.endEditing(true)
    }
    
    func checkCacheServices() {
        guard let vc = viewController else { return }
        if let services = vc.cache?.recordCache.services?.data {
            self.viewController.servicesBuffer = services
            self.viewController.services = services
            self.checkIfPlaceholderNeeded()
            self.viewController.tableView.reloadData()
        } else {
            getServices()
        }
    }
    
    func getServices() {
        SVProgressHUD.show()
        service.getServices().subscribe { (response) in
            SVProgressHUD.dismiss()
            if response.success ?? false {
                if self.viewController != nil {
                    self.viewController.cache?.recordCache.services = response
                    self.viewController.servicesBuffer = response.data ?? []
                    self.viewController.services = response.data ?? []
                    self.checkIfPlaceholderNeeded()
                    self.viewController.tableView.reloadData()
                }
            } else {
                self.checkIfPlaceholderNeeded()
                SVProgressHUD.showError(withStatus: response.message)
            }
        } onError: { (error) in
            self.checkIfPlaceholderNeeded()
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func addService() {
        let vc = viewController.getControllerProfile(controller: .serviceAdd)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func chooseService() {
       // let items = viewController.tableView.indexPathsForSelectedRows ?? []
        var services: [Service] = []
        for item in viewController.servicesBuffer {
            if item.isSelected {
                services.append(item)
            }
        }
        
        if viewController.editdelegate != nil {
            viewController.editdelegate?.model?.services = services
        } else {
            viewController.delegate?.model.services = services
        }
        
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func checkIfPlaceholderNeeded() {
        if viewController.services.count != 0 {
            viewController.placeholderView.isHidden = true
        } else {
            viewController.placeholderView.isHidden = false
        }
    }
    
    func search(string: String) {
        self.viewController.services = []
        self.viewController.servicesBuffer.forEach { (service) in
            if "\(service.name ?? "")".lowercased().contains(string.lowercased()) {
                self.viewController.services.append(service)
            }
        }
        self.viewController.tableView.reloadData()
    }
}

