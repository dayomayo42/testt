//
//  SpecInterractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 24.10.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol SpecInteractorProtocol: class {
    func configureView()
    func getSpec()
}

class SpecInteractor: SpecInteractorProtocol {
    weak var viewController: SpecController!
    weak var presenter: SpecPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: SpecController, presenter: SpecPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
    }
    
    func getSpec() {
        let idStr = viewController.sphereID
        
        SVProgressHUD.show()
        service.getSpecs(id: idStr).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.specs = response.data ?? []
                    self.viewController.tableView.reloadData()
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}

