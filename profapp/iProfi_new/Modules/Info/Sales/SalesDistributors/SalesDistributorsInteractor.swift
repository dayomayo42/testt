//
//  SaleDistributorsInteractor.swift
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

protocol SalesDistributorsInteractorProtocol {
    func configureView()
    func getSalesByDistributors(id: Int)
}

class SalesDistributorsInteractor: SalesDistributorsInteractorProtocol {
    var viewController: SalesDistributorsController!
    var presenter: SalesDistributorsPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    
    init(viewController: SalesDistributorsController, presenter: SalesDistributorsPresenterProtocol) {
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
        
        checkPlacehodler()
    }
    
    func checkPlacehodler() {
        guard let vc = viewController else { return }
        if vc.model?.data?.count == 0 {
            vc.placeholderView.isHidden = false
        } else {
            vc.placeholderView.isHidden = true
        }
    }
    
    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }
    
    func getSalesByDistributors(id: Int) {
        SVProgressHUD.show()
        service.getSalesByDistributors(id: id).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.presenter.openSalesCategoryNext(model: response)
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}
