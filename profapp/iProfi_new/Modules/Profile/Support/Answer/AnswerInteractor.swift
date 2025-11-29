//
//  AnswerInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol AnswerInteractorProtocol: class {
    func configureView()
    func openDetail(model: AnswerQuest)
    func getQuest()
}

class AnswerInteractor: AnswerInteractorProtocol {
    weak var viewController: AnswerController!
    weak var presenter: AnswerPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: AnswerController, presenter: AnswerPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        if let myURL = URL(string: "https://profapp.app/instruction.php") {
            let myURLRequest = URLRequest(url: myURL)
            viewController.webView.load(myURLRequest)
        }
    }
    
    func openDetail(model: AnswerQuest) {
        let vc = viewController.getControllerProfile(controller: .answerdeatiled) as! AnswerDetailController
        vc.model = model
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getQuest() {
        SVProgressHUD.show()
        service.getAnswers().subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
//                    self.viewController.list = response.data ?? []
//                    self.viewController.tableView.reloadData()
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}

