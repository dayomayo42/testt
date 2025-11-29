//
//  MyStudyInteractor.swift
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
import AVFAudio

protocol MyStudyInteractorProtocol {
    func configureView()
    func getStudy(id: Int)
}

class MyStudyInteractor: MyStudyInteractorProtocol {
    var viewController: MyStudyController!
    var presenter: MyStudyPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: MyStudyController, presenter: MyStudyPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        if viewController.model?.count == 0 {
            viewController.plugView.isHidden = false
        } else {
            viewController.plugView.isHidden = true
        }
    }
    
    func getStudy(id: Int) {
        SVProgressHUD.show()
        service.getStudy(id: id).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    if let studyModel = response.data?[0] {
                        self.presenter.openStudyDetail(model: studyModel)
                    }
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}
