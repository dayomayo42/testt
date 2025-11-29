//
//  FinanceAddConsumptionInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.11.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol FinanceAddConsumptionInteractorProtocol: class {
    func configureView()
    func checkField()
    func postFinance(type: String, name: String, price: Int, comment: String)
}

class FinanceAddConsumptionInteractor: FinanceAddConsumptionInteractorProtocol {
    weak var viewController: FinanceAddConsumptionController!
    weak var presenter: FinanceAddConsumptionPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: FinanceAddConsumptionController, presenter: FinanceAddConsumptionPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        viewController.saveButton.isActive = false
        
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: viewController.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        doneBtn.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        viewController.nameField.inputAccessoryView = toolbar
        viewController.sumField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }
    
    func checkField() {
        if viewController.nameField.text?.count ?? 0 > 0 && viewController.sumField.text?.count ?? 0 > 0 {
            viewController.saveButton.isActive = true
        } else {
            viewController.saveButton.isActive = false
        }
    }
    
    func postFinance(type: String, name: String, price: Int, comment: String) {
        SVProgressHUD.show()
        
        service.postFinance(type: type, name: name, price: price, comment: comment).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.navigationController?.popViewController(animated: true)
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}

