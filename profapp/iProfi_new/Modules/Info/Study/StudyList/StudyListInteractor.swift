//
//  StudyListInteractor.swift
//  iProfi_new
//
//  Created by violy on 12.08.2022.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD
import StoreKit

protocol StudyListInteractorProtocol {
    func configureView()
    func getStudy(id: Int)
}

class StudyListInteractor: StudyListInteractorProtocol {
    var viewController: StudyListController!
    var presenter: StudyListPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: StudyListController, presenter: StudyListPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        guard let vc = viewController else { return }
        vc.headerTitleLabel.text = vc.headerName
        vc.tableView.reloadData()
    }
    
    
    func getStudy(id: Int) {
        SVProgressHUD.show()
        service.getStudy(id: id).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    if let studyModel = response.data?[0] {
                        self.presenter.goToStudy(model: studyModel)
                    }
                } else {
                    SVProgressHUD.showError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}
