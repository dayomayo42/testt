//
//  SalesCategoryInteractor.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD
import StoreKit

protocol SalesCategoryInteractorProtocol {
    func configureView()
    func getSalesByCategory(id: Int, completion: @escaping (SliderModelSales) -> ())
}

class SalesCategoryInteractor: SalesCategoryInteractorProtocol {
    var viewController: SalesCategoryController!
    var presenter: SalesCategoryPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: SalesCategoryController, presenter: SalesCategoryPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        guard let vc = viewController else { return }
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: vc.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        doneBtn.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        vc.searchTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }
    
    
    func getSalesByCategory(id: Int, completion: @escaping (SliderModelSales) -> ()) {
        SVProgressHUD.show()
        service.getSalesByCategory(id: id).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    completion(response)
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}
