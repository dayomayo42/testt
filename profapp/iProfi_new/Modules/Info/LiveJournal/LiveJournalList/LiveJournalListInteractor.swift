//
//  LiveJournalListInteractor.swift
//  iProfi_new
//
//  Created by violy on 16.08.2022.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD
import StoreKit


protocol LiveJournalListInteractorProtocol {
    func configureView()
    func getJournalItem(id: Int)
}

class LiveJournalListInteractor: LiveJournalListInteractorProtocol {
    var viewController: LiveJournalListController!
    var presenter: LiveJournalListPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    var way = ""
    
    init(viewController: LiveJournalListController, presenter: LiveJournalListPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        switch viewController.state {
        case .news:
            viewController.headerTitleLabel.text = "Новости"
        case .exhibition:
            viewController.headerTitleLabel.text = "Выставки"
        case .article:
            viewController.headerTitleLabel.text = "Статьи"
        case .none:
            break
        }
    }
    
    func getJournalItem(id: Int) {
        SVProgressHUD.show()
        service.getLiveJournalItem(id: id).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    if let model = response.data?[0] {
                        self.presenter.openLiveJJournalDetail(model: model)
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
