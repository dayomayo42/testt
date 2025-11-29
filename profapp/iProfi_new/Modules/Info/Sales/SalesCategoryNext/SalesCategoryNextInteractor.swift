//
//  SalesCategoryNextInteractor.swift
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

protocol SalesCategoryNextInteractorProtocol {
    func configureView()
    func getSale(id: Int)
}

class SalesCategoryNextInteractor: SalesCategoryNextInteractorProtocol {
    var viewController: SalesCategoryNextController!
    var presenter: SalesCategoryNextPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: SalesCategoryNextController, presenter: SalesCategoryNextPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        guard let vc = viewController else { return }
        vc.headerLabel.text = vc.headerLabelText
        if vc.model?.data.count == 0 {
            vc.plugView.isHidden = false
        } else {
            vc.plugView.isHidden = true
        }
    }
    
    func getSale(id: Int) {
        SVProgressHUD.show()
        service.getSale(id: id).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    if let model = response.data[0] {
                        self.presenter.openSales(model: model)
                    }
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}
