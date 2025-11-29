//
//  FeedbackInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol FeedbackInteractorProtocol: class {
    func configureView()
    func checkView()
    func sendAction()
}

class FeedbackInteractor: FeedbackInteractorProtocol {
    weak var viewController: FeedbackController!
    weak var presenter: FeedbackPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: FeedbackController, presenter: FeedbackPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        viewController.sendButton.isActive = false
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: viewController.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        doneBtn.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        viewController.nameLabel.inputAccessoryView = toolbar
        viewController.mailLabel.inputAccessoryView = toolbar
        viewController.textView.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }
    
    func checkView() {
        if viewController.nameLabel.text?.count ?? 0 > 0 && viewController.mailLabel.text?.count ?? 0 > 0 && viewController.textView.text?.count ?? 0 > 0 {
            viewController.sendButton.isActive = true
        } else {
            viewController.sendButton.isActive = false
        }
    }
    
    func sendAction() {
        SVProgressHUD.show()
        service.postFeedback(name: viewController.nameLabel.text ?? "", mail: viewController.mailLabel.text ?? "", message: viewController.textView.text ?? "").subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.navigationController?.popToRootViewController(animated: true)
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)

    }
}

