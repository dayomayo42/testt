//
//  RecordsSearchInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.10.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol RecordsSearchInteractorProtocol: class {
    func configureView()
    func clearField()
    func showClearButton(from text: String)
    func sendRequest(string: String)
    func searchByString(string: String)
}

class RecordsSearchInteractor: RecordsSearchInteractorProtocol {
    weak var viewController: RecordsSearchController!
    weak var presenter: RecordsSearchPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    var showAll = false

    init(viewController: RecordsSearchController, presenter: RecordsSearchPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }

    func configureView() {
        
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: viewController.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        doneBtn.tintColor = UIColor(named: "appBlue")
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()

        viewController.searchField.inputAccessoryView = toolbar
        
        viewController.allRecords = sortRecords(records: viewController.allRecords)
        viewController.records = viewController.allRecords
    }
    
    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }
    
    func clearField() {
        guard let vc = viewController else { return }
        vc.searchField.text = ""
        vc.clearButton.isHidden = true
        vc.records = vc.allRecords
    }
    
    func showClearButton(from text: String) {
        viewController.clearButton.isHidden = !(text.count > 0)
    }
    
    func sortRecords(records: [Records]) -> [Records] {
        return records.sorted(by: { $0.date?.convertDateToDate().timeIntervalSince1970 ?? 0 > $1.date?.convertDateToDate().timeIntervalSince1970 ?? 0 })
    }
    
    func searchByString(string: String) {
        
        guard let vc = viewController else { return }
    
        vc.debouncer.renewInterval()
        
        guard string.count >= 3 else {
            vc.debouncer.stopTimer()
            if showAll {
                showAll = false
                vc.records = vc.allRecords
            }
            return
        }
        
        showAll = true
        
        vc.debouncer.handler = {
            
            let allRecords = vc.allRecords
            var resultArr: [Records] = []
            
            allRecords.forEach { record in
                
                record.client?.forEach({ client in
                    let fullNameStr = (client.name?.lowercased() ?? "") + (client.midname?.lowercased() ?? "") + (client.lastname?.lowercased() ?? "")
                    if fullNameStr.withoutSpaces().contains(string.withoutSpaces().lowercased()) {
                        resultArr.append(record)
                    }
                })
                
                record.services?.forEach({ service in
                    if service.name?.lowercased().contains(string.lowercased()) ?? false {
                        resultArr.append(record)
                    }
                })
                
                record.expandables?.forEach({ product in
                    if product.name?.lowercased().contains(string.lowercased()) ?? false {
                        resultArr.append(record)
                    }
                })
            }
            
            vc.records = self.sortRecords(records: resultArr.removeDuplicates())
        }
    }
    
    func sendRequest(string: String) {
        guard let vc = viewController else { return }
        
        vc.debouncer.renewInterval()
        
        guard string.count >= 3 else {
            vc.debouncer.stopTimer()
            vc.records = viewController.allRecords
            return
        }
    
        vc.debouncer.handler = {
            SVProgressHUD.show()
            self.service.searchRecords(phrase: string).subscribe { (response) in
                SVProgressHUD.dismiss()
                if response.success ?? false {
                    vc.records = response.data ?? []
                    vc.placeholderView.isHidden = response.data?.count ?? 0 > 0
                    vc.tableView.reloadData()
                } else {
                    vc.records = []
                    SVProgressHUD.dismiss()
                }
                
            } onError: { (error) in
                vc.records = []
                SVProgressHUD.dismiss()
            }.disposed(by: self.disposeBag)
        }
    }
}
